import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:surface/controllers/chat_message_controller.dart';

class ChatMessageInput extends StatefulWidget {
  final ChatMessageController controller;
  const ChatMessageInput({super.key, required this.controller});

  @override
  State<ChatMessageInput> createState() => _ChatMessageInputState();
}

class _ChatMessageInputState extends State<ChatMessageInput> {
  final TextEditingController _contentController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  void _sendMessage() {
    widget.controller.sendMessage(
      'messages.new',
      _contentController.text,
    );
    _contentController.clear();
  }

  @override
  void dispose() {
    _contentController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  focusNode: _focusNode,
                  controller: _contentController,
                  decoration: InputDecoration(
                    isCollapsed: true,
                    hintText: 'Type a message...',
                    border: InputBorder.none,
                  ),
                  onSubmitted: (_) {
                    _sendMessage();
                    _focusNode.requestFocus();
                  },
                ),
              ),
              const Gap(8),
              IconButton(
                onPressed: _sendMessage,
                icon: Icon(
                  Symbols.send,
                  color: Theme.of(context).colorScheme.primary,
                ),
                visualDensity: const VisualDensity(
                  horizontal: -4,
                  vertical: -4,
                ),
              ),
            ],
          ).padding(horizontal: 16, vertical: 12),
        ],
      ),
    );
  }
}
