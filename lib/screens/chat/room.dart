import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:surface/controllers/chat_message_controller.dart';
import 'package:surface/providers/channel.dart';
import 'package:surface/types/chat.dart';
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

  SnChannel? _channel;

  final GlobalKey<ChatMessageInputState> _inputGlobalKey = GlobalKey();
  late final ChatMessageController _messageController;

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

  @override
  void initState() {
    super.initState();
    _messageController = ChatMessageController(context);
    _fetchChannel().then((_) async {
      await _messageController.initialize(_channel!);
      await _messageController.checkUpdate();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_channel?.name ?? 'loading'.tr()),
      ),
      body: ListenableBuilder(
        listenable: _messageController,
        builder: (context, _) {
          return Column(
            children: [
              LoadingIndicator(isActive: _isBusy),
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
                      final nextMessage =
                          idx < _messageController.messages.length - 1
                              ? _messageController.messages[idx + 1]
                              : null;
                      final previousMessage =
                          idx > 0 ? _messageController.messages[idx - 1] : null;

                      final canMerge = nextMessage != null &&
                          nextMessage.senderId == message.senderId &&
                          message.createdAt
                                  .difference(nextMessage.createdAt)
                                  .inMinutes
                                  .abs() <=
                              3;
                      final canMergePrevious = previousMessage != null &&
                          previousMessage.senderId == message.senderId &&
                          message.createdAt
                                  .difference(previousMessage.createdAt)
                                  .inMinutes
                                  .abs() <=
                              3;

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
