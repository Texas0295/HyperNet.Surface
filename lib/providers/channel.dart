import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:surface/providers/sn_network.dart';
import 'package:surface/types/chat.dart';
import 'package:surface/types/realm.dart';

class ChatChannelProvider extends ChangeNotifier {
  static const kChatChannelBoxName = 'nex_chat_channels';

  late final SnNetworkProvider _sn;

  Box<SnChannel>? get _channelBox => Hive.box<SnChannel>(kChatChannelBoxName);

  ChatChannelProvider(BuildContext context) {
    _sn = context.read<SnNetworkProvider>();
    _initializeLocalData();
  }

  Future<void> _initializeLocalData() async {
    await Hive.openBox<SnChannel>(kChatChannelBoxName);
  }

  Future<void> _saveChannelToLocal(Iterable<SnChannel> channels) async {
    if (_channelBox == null) return;
    await _channelBox!.putAll({
      for (final channel in channels) channel.key: channel,
    });
  }

  Future<List<SnChannel>> _fetchChannelsFromServer({
    String scope = 'global',
    bool direct = false,
    bool doNotSave = false,
  }) async {
    final resp = await _sn.client.get(
      '/cgi/im/channels/$scope/me/available',
      queryParameters: {
        'direct': direct,
      },
    );
    final out = List<SnChannel>.from(
      resp.data?.map((e) => SnChannel.fromJson(e)) ?? [],
    );
    if (!doNotSave) _saveChannelToLocal(out);
    return out;
  }

  /// The get channel method will return the channel with the given alias.
  /// It will use the local storage as much as possible.
  /// The alias should include the scope, formatted as `scope:alias`.
  Future<SnChannel> getChannel(String key) async {
    if (_channelBox != null) {
      final local = _channelBox!.get(key);
      if (local != null) return local;
    }

    var resp = await _sn.client.get('/cgi/im/channels/$key');
    var out = SnChannel.fromJson(resp.data);

    // Preload realm of the channel
    if (out.realmId != null) {
      resp = await _sn.client.get('/cgi/id/realms/${out.realmId}');
      out = out.copyWith(realm: SnRealm.fromJson(resp.data));
    }

    _saveChannelToLocal([out]);
    return out;
  }

  /// The fetch channel method return a stream, which will emit twice.
  /// The first time is when the data was fetched from the local storage.
  /// And the second time is when the data was fetched from the server.
  /// But there is some exception that will only cause one of them to be emitted.
  /// Like the local storage is broken or the server is down.
  Stream<List<SnChannel>> fetchChannels() async* {
    if (_channelBox != null) yield _channelBox!.values.toList();

    var resp = await _sn.client.get('/cgi/id/realms/me/available');
    final realms = List<SnRealm>.from(
      resp.data?.map((e) => SnRealm.fromJson(e)) ?? [],
    );
    final realmMap = {
      for (final realm in realms) realm.alias: realm,
    };

    final scopeToFetch = {'global', ...realms.map((e) => e.alias)};

    final List<SnChannel> result = List.empty(growable: true);
    final directMessages = await _fetchChannelsFromServer(
      scope: scopeToFetch.first,
      direct: true,
    );
    result.addAll(directMessages);

    final nonBelongsChannels = await _fetchChannelsFromServer(
      scope: scopeToFetch.first,
      direct: false,
    );
    result.addAll(nonBelongsChannels);

    for (final scope in scopeToFetch.skip(1)) {
      final channel = await _fetchChannelsFromServer(
        scope: scope,
        direct: false,
        doNotSave: true,
      );
      final out = channel.map((ele) => ele.copyWith(realm: realmMap[scope]));
      _saveChannelToLocal(out);
      result.addAll(out);
    }

    yield result;
  }

  @override
  void dispose() {
    _channelBox?.close();
    super.dispose();
  }
}
