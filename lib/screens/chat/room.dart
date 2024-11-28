import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:surface/controllers/chat_message_controller.dart';
import 'package:surface/providers/channel.dart';
import 'package:surface/providers/chat_call.dart';
import 'package:surface/providers/sn_network.dart';
import 'package:surface/providers/websocket.dart';
import 'package:surface/types/chat.dart';
import 'package:surface/widgets/chat/call/call_prejoin.dart';
import 'package:surface/widgets/chat/chat_message.dart';
import 'package:surface/widgets/chat/chat_message_input.dart';
import 'package:surface/widgets/dialog.dart';
import 'package:surface/widgets/loading_indicator.dart';
import 'package:very_good_infinite_list/very_good_infinite_list.dart';

class ChatRoomScreen extends StatefulWidget {
  final String scope;
  final String alias;
  const ChatRoomScreen({super.key, required this.scope, required this.alias});

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  bool _isBusy = false;
  bool _isCalling = false;

  SnChannel? _channel;
  SnChatCall? _ongoingCall;

  final GlobalKey<ChatMessageInputState> _inputGlobalKey = GlobalKey();
  late final ChatMessageController _messageController;

  StreamSubscription? _wsSubscription;

  Future<void> _fetchChannel() async {
    setState(() => _isBusy = true);

    try {
      final chan = context.read<ChatChannelProvider>();
      _channel = await chan.getChannel('${widget.scope}:${widget.alias}');
    } catch (err) {
      if (!mounted) return;
      context.showErrorDialog(err);
    } finally {
      setState(() => _isBusy = false);
    }
  }

  Future<void> _fetchOngoingCall() async {
    setState(() => _isCalling = true);

    try {
      final sn = context.read<SnNetworkProvider>();
      final resp = await sn.client.get(
        '/cgi/im/channels/${_messageController.channel!.keyPath}/calls/ongoing',
        options: Options(
          validateStatus: (status) => status != null && status < 500,
        ),
      );
      if (resp.statusCode == 200) {
        _ongoingCall = SnChatCall.fromJson(resp.data);
      }
    } catch (err) {
      if (!mounted) return;
      context.showErrorDialog(err);
    } finally {
      setState(() => _isCalling = false);
    }
  }

  Future<void> _makeCall() async {
    setState(() => _isCalling = true);

    try {
      final sn = context.read<SnNetworkProvider>();
      final resp = await sn.client.post(
        '/cgi/im/channels/${_messageController.channel!.keyPath}/calls',
        options: Options(
          sendTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
        ),
      );
      log(jsonDecode(resp.data));
    } catch (err) {
      if (!mounted) return;
      context.showErrorDialog(err);
    } finally {
      setState(() => _isCalling = false);
    }
  }

  Future<void> _endCall() async {
    setState(() => _isCalling = true);

    try {
      final sn = context.read<SnNetworkProvider>();
      await sn.client.delete(
        '/cgi/im/channels/${_messageController.channel!.keyPath}/calls/ongoing',
      );
    } catch (err) {
      if (!mounted) return;
      context.showErrorDialog(err);
    } finally {
      setState(() => _isCalling = false);
    }
  }

  Future<void> _onCallJoin() async {
    await showModalBottomSheet(
      context: context,
      builder: (context) => ChatCallPrejoinPopup(
        ongoingCall: _ongoingCall!,
        channel: _channel!,
        onJoin: _onCallResume,
      ),
    );
  }

  void _onCallResume() {
    GoRouter.of(context).pushNamed(
      'chatCallRoom',
      pathParameters: {
        'scope': _channel!.realm!.alias,
        'alias': _channel!.alias,
      },
    );
  }

  bool _checkMessageMergeable(SnChatMessage? a, SnChatMessage? b) {
    if (a == null || b == null) return false;
    if (a.sender.accountId != b.sender.accountId) return false;
    return a.createdAt.difference(b.createdAt).inMinutes <= 3;
  }

  @override
  void initState() {
    super.initState();
    _messageController = ChatMessageController(context);
    _fetchChannel().then((_) async {
      await _messageController.initialize(_channel!);
      await _messageController.checkUpdate();
      await _fetchOngoingCall();
    });

    final ws = context.read<WebSocketProvider>();
    _wsSubscription = ws.stream.stream.listen((event) {
      switch (event.method) {
        case 'calls.new':
          final payload = SnChatCall.fromJson(event.payload!);
          if (payload.channelId == _channel?.id) {
            setState(() => _ongoingCall = payload);
          }
          break;
        case 'calls.end':
          final payload = SnChatCall.fromJson(event.payload!);
          if (payload.channelId == _channel?.id) {
            setState(() => _ongoingCall = null);
          }
          break;
      }
    });
  }

  @override
  void dispose() {
    _wsSubscription?.cancel();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final call = context.watch<ChatCallProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(_channel?.name ?? 'loading'.tr()),
        actions: [
          IconButton(
            icon: _ongoingCall == null
                ? const Icon(Symbols.call)
                : const Icon(Symbols.call_end),
            onPressed: _isCalling
                ? null
                : _ongoingCall == null
                    ? _makeCall
                    : _endCall,
          ),
          IconButton(
            icon: const Icon(Symbols.more_vert),
            onPressed: () {
              GoRouter.of(context).pushNamed('channelDetail', pathParameters: {
                'scope': widget.scope,
                'alias': widget.alias,
              }).then((value) {
                if (value != null) {
                  _fetchChannel();
                }
              });
            },
          ),
          const Gap(8),
        ],
      ),
      body: ListenableBuilder(
        listenable: _messageController,
        builder: (context, _) {
          return Column(
            children: [
              LoadingIndicator(isActive: _isBusy),
              SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: MaterialBanner(
                  dividerColor: Colors.transparent,
                  leading: const Icon(Symbols.call_received),
                  content: Text('callOngoingNotice').tr().padding(top: 2),
                  actions: [
                    if (call.current == null)
                      TextButton(
                        onPressed: _onCallJoin,
                        child: Text('callJoin').tr(),
                      )
                    else if (call.current?.channelId == _channel?.id)
                      TextButton(
                        onPressed: _onCallResume,
                        child: Text('callResume').tr(),
                      )
                  ],
                ),
              ).height(_ongoingCall != null ? 54 : 0, animate: true).animate(
                  const Duration(milliseconds: 300),
                  Curves.fastLinearToSlowEaseIn),
              if (_messageController.isPending)
                Expanded(
                  child: const CircularProgressIndicator().center(),
                ),
              if (!_messageController.isPending)
                Expanded(
                  child: InfiniteList(
                    reverse: true,
                    padding: const EdgeInsets.only(
                      left: 12,
                      right: 12,
                      top: 12,
                    ),
                    hasReachedMax: _messageController.isAllLoaded,
                    itemCount: _messageController.messages.length,
                    isLoading: _messageController.isLoading,
                    onFetchData: () {
                      _messageController.loadMessages();
                    },
                    itemBuilder: (context, idx) {
                      final message = _messageController.messages[idx];

                      bool canMerge = false, canMergePrevious = false;
                      if (idx > 0) {
                        canMergePrevious = _checkMessageMergeable(
                          _messageController.messages[idx - 1],
                          _messageController.messages[idx],
                        );
                      }
                      if (idx + 1 < _messageController.messages.length) {
                        canMerge = _checkMessageMergeable(
                          _messageController.messages[idx],
                          _messageController.messages[idx + 1],
                        );
                      }

                      return ChatMessage(
                        data: message,
                        isMerged: canMerge,
                        hasMerged: canMergePrevious,
                        isPending: _messageController.unconfirmedMessages
                            .contains(message.uuid),
                        onReply: (value) {
                          _inputGlobalKey.currentState?.setReply(value);
                        },
                        onEdit: (value) {
                          _inputGlobalKey.currentState?.setEdit(value);
                        },
                        onDelete: (value) {
                          _inputGlobalKey.currentState?.deleteMessage(value);
                        },
                      );
                    },
                  ),
                ),
              if (!_messageController.isPending)
                Material(
                  elevation: 2,
                  child: ChatMessageInput(
                    key: _inputGlobalKey,
                    controller: _messageController,
                  ).padding(bottom: MediaQuery.of(context).padding.bottom),
                ),
            ],
          );
        },
      ),
    );
  }
}
