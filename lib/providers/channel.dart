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

  Future<List<SnChannel>> _fetchChannelsFromServer(
      {scope = 'global', direct = false}) async {
    final resp = await _sn.client.get(
      '/cgi/im/channels/$scope/me/available',
      queryParameters: {
        'direct': direct,
      },
    );
    final out = List<SnChannel>.from(
      resp.data?.map((e) => SnChannel.fromJson(e)) ?? [],
    );
    _saveChannelToLocal(out);
    return out;
  }

  // The fetch channel method return a stream, which will emit twice.
  // The first time is when the data was fetched from the local storage.
  // And the second time is when the data was fetched from the server.
  // But there is some exception that will only cause one of them to be emitted.
  // Like the local storage is broken or the server is down.
  Stream<List<SnChannel>> fetchChannels() async* {
    if (_channelBox != null) yield _channelBox!.values.toList();

    var resp = await _sn.client.get('/cgi/id/realms/me/available');
    final realms = List<SnRealm>.from(
      resp.data?.map((e) => SnRealm.fromJson(e)) ?? [],
    );

    final scopeToFetch = {'global', ...realms.map((e) => e.alias)};

    final List<SnChannel> result = List.empty(growable: true);
    final dm =
        await _fetchChannelsFromServer(scope: scopeToFetch.first, direct: true);
    result.addAll(dm);

    for (final scope in scopeToFetch) {
      final channel =
          await _fetchChannelsFromServer(scope: scope, direct: false);
      result.addAll(channel);
    }

    yield result;
  }

  @override
  void dispose() {
    _channelBox?.close();
    super.dispose();
  }
}
