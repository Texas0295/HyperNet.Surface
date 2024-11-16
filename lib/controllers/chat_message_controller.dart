import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:surface/providers/sn_network.dart';
import 'package:surface/providers/user_directory.dart';
import 'package:surface/types/chat.dart';
import 'package:uuid/uuid.dart';

class ChatMessageController extends ChangeNotifier {
  static const kChatMessageBoxPrefix = 'nex_chat_messages_';
  static const kSingleBatchLoadLimit = 100;

  late final SnNetworkProvider _sn;
  late final UserDirectoryProvider _ud;

  ChatMessageController(BuildContext context) {
    _sn = context.read<SnNetworkProvider>();
    _ud = context.read<UserDirectoryProvider>();
  }

  bool isPending = true;
  bool isLoading = false;

  int? messageTotal;

  bool get isAllLoaded =>
      messageTotal != null && messages.length >= messageTotal!;

  String? _boxKey;
  SnChannel? _channel;

  List<SnChatMessage> messages = List.empty(growable: true);

  Box<SnChatMessage>? get _box =>
      (_boxKey == null || isPending) ? null : Hive.box<SnChatMessage>(_boxKey!);

  Future<void> initialize(SnChannel channel) async {
    _channel = channel;
    _boxKey = '$kChatMessageBoxPrefix${channel.id}';
    await Hive.openBox<SnChatMessage>(_boxKey!);
    isPending = false;
    notifyListeners();
  }

  Future<void> _saveMessageToLocal(Iterable<SnChatMessage> messages) async {
    if (_box == null) return;
    await _box!.putAll({
      for (final message in messages) message.id: message,
    });
  }

  Future<void> _addMessage(SnChatMessage message) async {
    messages.add(message);
    notifyListeners();

    if (_box == null) return;
    await _box!.put(message.id, message);
  }

  Future<void> sendMessage(
    String type,
    String content, {
    int? quoteId,
    int? relatedId,
    List<String>? attachments,
  }) async {
    if (_channel == null) return;
    const uuid = Uuid();
    final nonce = uuid.v4();
    final resp = await _sn.client.post(
      '/cgi/im/channels/${_channel!.keyPath}/messages',
      data: {
        'type': type,
        'uuid': nonce,
        'body': {
          'text': content,
          'algorithm': 'plain',
          if (quoteId != null) 'quote_id': quoteId,
          if (relatedId != null) 'related_id': relatedId,
          if (attachments != null) 'attachments': attachments,
        },
      },
    );
    final out = SnChatMessage.fromJson(
      resp.data['data'] as Map<String, dynamic>,
    );
    await _addMessage(out);
  }

  /// Check the local storage is up to date with the server.
  /// If the local storage is not up to date, it will be updated.
  Future<void> checkUpdate() async {
    if (_box == null) return;
    if (_box!.isEmpty) return;

    isLoading = true;
    notifyListeners();

    try {
      final resp = await _sn.client.get(
        '/cgi/im/channels/${_channel!.keyPath}/events/update',
        queryParameters: {
          'pivot': _box!.values.last.id,
        },
      );
      if (resp.data['up_to_date'] == true) {
        await loadMessages();
        return;
      }
      // Only preload the first 100 messages to prevent first time check update cause load to server and waste local storage.
      // FIXME If the local is missing more than 100 messages, it won't be fetched, this is a problem, we need to fix it.
      final countToFetch = math.min(resp.data['count'] as int, 100);

      for (int idx = 0; idx < countToFetch; idx += kSingleBatchLoadLimit) {
        await getMessages(kSingleBatchLoadLimit, idx);
      }
    } catch (err) {
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// Get message from local storage first, then from the server.
  /// Will not check local storage is up to date with the server.
  /// If you need to do the sync, do the `checkUpdate` instead.
  Future<List<SnChatMessage>> getMessages(
    int take,
    int offset, {
    bool forceLocal = false,
  }) async {
    if (_box != null) {
      // Try retrieve these messages from the local storage
      if (_box!.length >= take + offset || forceLocal) {
        return _box!.values.skip(offset).take(take).toList();
      }
    }

    final resp = await _sn.client.get(
      '/cgi/im/channels/${_channel!.keyPath}/events',
      queryParameters: {
        'take': take,
        'offset': offset,
      },
    );
    messageTotal = resp.data['count'] as int?;
    final out = List<SnChatMessage>.from(
      resp.data['data']?.map((e) => SnChatMessage.fromJson(e)) ?? [],
    );
    _saveMessageToLocal(out);

    // Preload sender accounts
    await _ud.listAccount(out.map((ele) => ele.sender.accountId).toSet());

    return out;
  }

  /// The load messages method work as same as the `getMessages` method.
  /// But it won't return the messages instead append them to the value that controller has.
  /// At the same time, this method provide the `isLoading` state.
  /// The `skip` parameter is no longer required since it will skip the messages count that already loaded.
  Future<void> loadMessages({int take = 20}) async {
    isLoading = true;
    notifyListeners();

    try {
      final out = await getMessages(take, messages.length);
      messages.addAll(out);
    } catch (err) {
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  close() {
    _box?.close();
  }
}
