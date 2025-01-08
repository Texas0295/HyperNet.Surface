import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:surface/controllers/chat_message_controller.dart';
import 'package:surface/controllers/post_write_controller.dart';
import 'package:surface/providers/sn_attachment.dart';
import 'package:surface/providers/user_directory.dart';
import 'package:surface/types/attachment.dart';
import 'package:surface/types/chat.dart';
import 'package:surface/widgets/dialog.dart';
import 'package:surface/widgets/post/post_media_pending_list.dart';

class ChatMessageInput extends StatefulWidget {
  final ChatMessageController controller;
  final SnChannelMember? otherMember;

  const ChatMessageInput({super.key, required this.controller, this.otherMember});

  @override
  State<ChatMessageInput> createState() => ChatMessageInputState();
}

class ChatMessageInputState extends State<ChatMessageInput> {
  bool _isBusy = false;
  double? _progress;

  SnChatMessage? _replyingMessage, _editingMessage;

  final TextEditingController _contentController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _contentController.addListener(() {
      if (_contentController.text.isNotEmpty) {
        widget.controller.pingTypingStatus();
      }
    });
  }

  void setReply(SnChatMessage? value) {
    setState(() => _replyingMessage = value);
  }

  void setEdit(SnChatMessage? value) {
    _contentController.text = value?.body['text'] ?? '';
    setState(() => _editingMessage = value);
  }

  Future<void> deleteMessage(SnChatMessage message) async {
    final confirm = await context.showConfirmDialog(
      'messageDelete'.tr(args: ['#${message.id}']),
      'messageDeleteDescription'.tr(),
    );
    if (!confirm) return;

    if (!mounted) return;
    setState(() => _isBusy = true);

    await widget.controller.deleteMessage(message);

    if (!mounted) return;
    setState(() => _isBusy = false);
  }

  Future<void> _sendMessage() async {
    if (_isBusy) return;

    final attach = context.read<SnAttachmentProvider>();

    setState(() => _isBusy = true);

    try {
      for (int i = 0; i < _attachments.length; i++) {
        final media = _attachments[i];
        if (media.attachment != null) continue; // Already uploaded, skip
        if (media.isEmpty) continue; // Nothing to do, skip

        final place = await attach.chunkedUploadInitialize(
          (await media.length())!,
          media.name,
          'messaging',
          null,
          mimetype: media.raw != null && media.type == SnMediaType.image ? 'image/png' : null,
        );

        final item = await attach.chunkedUploadParts(
          media.toFile()!,
          place.$1,
          place.$2,
          analyzeNow: media.type == SnMediaType.image,
          onProgress: (progress) {
            // Calculate overall progress for attachments
            setState(() {
              progress = (i + progress) / _attachments.length;
            });
          },
        );

        setState(() {
          _attachments[i] = PostWriteMedia(item);
        });
      }
    } catch (err) {
      if (!mounted) return;
      setState(() => _isBusy = false);
      context.showErrorDialog(err);
      return;
    }

    // Send the message
    // NOTICE This future should not be awaited, so that the message can be sent in the background and the user can continue to type
    widget.controller.sendMessage(
      'messages.new',
      _contentController.text,
      attachments: _attachments.where((e) => e.attachment != null).map((e) => e.attachment!.rid).toList(),
      relatedId: _editingMessage?.id,
      quoteId: _replyingMessage?.id,
      editingMessage: _editingMessage,
    );
    _contentController.clear();
    _attachments.clear();
    _editingMessage = null;
    _replyingMessage = null;

    setState(() => _isBusy = false);
  }

  final List<PostWriteMedia> _attachments = List.empty(growable: true);

  @override
  void dispose() {
    _contentController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ud = context.read<UserDirectoryProvider>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (_isBusy && _progress != null)
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: _progress),
            duration: Duration(milliseconds: 300),
            builder: (context, value, _) => LinearProgressIndicator(value: value, minHeight: 2),
          )
        else if (_isBusy)
          const LinearProgressIndicator(value: null, minHeight: 2),
        Padding(
          padding: _attachments.isNotEmpty ? const EdgeInsets.only(top: 8) : EdgeInsets.zero,
          child: PostMediaPendingList(
            attachments: _attachments,
            isBusy: _isBusy,
            onUpdate: (idx, updatedMedia) async {
              setState(() => _attachments[idx] = updatedMedia);
            },
            onRemove: (idx) async {
              setState(() => _attachments.removeAt(idx));
            },
            onUpdateBusy: (state) => setState(() => _isBusy = state),
          ),
        )
            .height(_attachments.isNotEmpty ? 80 + 8 : 0, animate: true)
            .animate(const Duration(milliseconds: 300), Curves.fastEaseInToSlowEaseOut),
        SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: _replyingMessage != null
              ? Container(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Theme.of(context).dividerColor,
                        width: 1 / MediaQuery.of(context).devicePixelRatio,
                      ),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Symbols.reply, size: 20),
                      const Gap(8),
                      Expanded(
                        child: Text(
                          _replyingMessage?.body['text'] ?? '${_replyingMessage?.sender.nick}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Gap(16),
                      InkWell(
                        child: Text('cancel'.tr()),
                        onTap: () {
                          setState(() => _replyingMessage = null);
                        },
                      ),
                    ],
                  ).padding(vertical: 8),
                )
              : const SizedBox.shrink(),
        )
            .height(_replyingMessage != null ? 38 : 0, animate: true)
            .animate(const Duration(milliseconds: 300), Curves.fastEaseInToSlowEaseOut),
        SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: _editingMessage != null
              ? Container(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Theme.of(context).dividerColor,
                        width: 1 / MediaQuery.of(context).devicePixelRatio,
                      ),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Symbols.edit, size: 20),
                      const Gap(8),
                      Expanded(
                        child: Text(
                          _editingMessage?.body['text'] ?? '${_editingMessage?.sender.nick}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Gap(16),
                      InkWell(
                        child: Text('cancel'.tr()),
                        onTap: () {
                          _contentController.clear();
                          setState(() => _editingMessage = null);
                        },
                      ),
                    ],
                  ).padding(vertical: 8),
                )
              : const SizedBox.shrink(),
        )
            .height(_editingMessage != null ? 38 : 0, animate: true)
            .animate(const Duration(milliseconds: 300), Curves.fastEaseInToSlowEaseOut),
        SizedBox(
          height: 56,
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  focusNode: _focusNode,
                  controller: _contentController,
                  decoration: InputDecoration(
                    isCollapsed: true,
                    hintText: widget.otherMember != null
                        ? 'fieldChatMessageDirect'.tr(args: [
                            '@${ud.getAccountFromCache(widget.otherMember?.accountId)?.name}',
                          ])
                        : 'fieldChatMessage'.tr(args: [widget.controller.channel?.name ?? 'loading'.tr()]),
                    border: InputBorder.none,
                  ),
                  onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
                  onSubmitted: (_) {
                    if (_isBusy) return;
                    _sendMessage();
                    _focusNode.requestFocus();
                  },
                ),
              ),
              const Gap(8),
              AddPostMediaButton(
                onAdd: (items) {
                  setState(() {
                    _attachments.addAll(items);
                  });
                },
              ),
              IconButton(
                onPressed: _isBusy ? null : _sendMessage,
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
          ),
        ).padding(horizontal: 16),
      ],
    );
  }
}
