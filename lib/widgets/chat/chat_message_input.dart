import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:pasteboard/pasteboard.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:surface/controllers/chat_message_controller.dart';
import 'package:surface/controllers/post_write_controller.dart';
import 'package:surface/providers/sn_attachment.dart';
import 'package:surface/types/chat.dart';
import 'package:surface/widgets/dialog.dart';
import 'package:surface/widgets/markdown_content.dart';
import 'package:surface/widgets/post/post_media_pending_list.dart';

class ChatMessageInput extends StatefulWidget {
  final ChatMessageController controller;
  const ChatMessageInput({super.key, required this.controller});

  @override
  State<ChatMessageInput> createState() => ChatMessageInputState();
}

class ChatMessageInputState extends State<ChatMessageInput> {
  bool _isBusy = false;
  double? _progress;

  SnChatMessage? _replyingMessage, _editingMessage;

  final TextEditingController _contentController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  void setReply(SnChatMessage? value) {
    setState(() => _replyingMessage = value);
  }

  void setEdit(SnChatMessage? value) {
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
          'interactive',
          null,
          mimetype: media.raw != null && media.type == PostWriteMediaType.image
              ? 'image/png'
              : null,
        );

        final item = await attach.chunkedUploadParts(
          media.toFile()!,
          place.$1,
          place.$2,
          onProgress: (progress) {
            // Calculate overall progress for attachments
            setState(() {
              progress = (i + progress) / _attachments.length;
            });
          },
        );

        _attachments[i] = PostWriteMedia(item);
      }
    } catch (err) {
      if (!mounted) return;
      setState(() => _isBusy = false);
      context.showErrorDialog(err);
      return;
    }

    attach.putCache(
      _attachments.where((e) => e.attachment != null).map((e) => e.attachment!),
      noCheck: true,
    );

    // Send the message
    // NOTICE This future should not be awaited, so that the message can be sent in the background and the user can continue to type
    widget.controller.sendMessage(
      'messages.new',
      _contentController.text,
      attachments: _attachments
          .where((e) => e.attachment != null)
          .map((e) => e.attachment!.rid)
          .toList(),
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
  final _imagePicker = ImagePicker();

  void _selectMedia() async {
    final result = await _imagePicker.pickMultipleMedia();
    if (result.isEmpty) return;
    _attachments.addAll(
      result.map((e) => PostWriteMedia.fromFile(e)),
    );
    setState(() {});
  }

  void _pasteMedia() async {
    final imageBytes = await Pasteboard.image;
    if (imageBytes == null) return;
    _attachments.add(
      PostWriteMedia.fromBytes(
        imageBytes,
        'attachmentPastedImage'.tr(),
        PostWriteMediaType.image,
      ),
    );
    setState(() {});
  }

  @override
  void dispose() {
    _contentController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (_isBusy && _progress != null)
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: _progress),
            duration: Duration(milliseconds: 300),
            builder: (context, value, _) =>
                LinearProgressIndicator(value: value, minHeight: 2),
          )
        else if (_isBusy)
          const LinearProgressIndicator(value: null, minHeight: 2),
        Padding(
          padding: _attachments.isNotEmpty
              ? const EdgeInsets.only(top: 8)
              : EdgeInsets.zero,
          child: PostMediaPendingListRaw(
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
        ).height(_attachments.isNotEmpty ? 80 + 8 : 0, animate: true).animate(
            const Duration(milliseconds: 300), Curves.fastEaseInToSlowEaseOut),
        SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Padding(
            padding: _replyingMessage != null
                ? const EdgeInsets.only(top: 8)
                : EdgeInsets.zero,
            child: _replyingMessage != null
                ? MaterialBanner(
                    padding: const EdgeInsets.only(left: 16.0),
                    leading: const Icon(Symbols.reply),
                    content: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (_replyingMessage?.body['text'] != null)
                            MarkdownTextContent(
                              content: _replyingMessage?.body['text'],
                            ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: Text('cancel'.tr()),
                        onPressed: () {
                          setState(() => _replyingMessage = null);
                        },
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
        ).height(_replyingMessage != null ? 54 + 8 : 0, animate: true).animate(
            const Duration(milliseconds: 300), Curves.fastEaseInToSlowEaseOut),
        SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Padding(
            padding: _editingMessage != null
                ? const EdgeInsets.only(top: 8)
                : EdgeInsets.zero,
            child: _editingMessage != null
                ? MaterialBanner(
                    padding: const EdgeInsets.only(left: 16.0),
                    leading: const Icon(Symbols.edit),
                    content: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (_editingMessage?.body['text'] != null)
                            MarkdownTextContent(
                              content: _editingMessage?.body['text'],
                            ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: Text('cancel'.tr()),
                        onPressed: () {
                          setState(() => _editingMessage = null);
                        },
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
        ).height(_editingMessage != null ? 54 + 8 : 0, animate: true).animate(
            const Duration(milliseconds: 300), Curves.fastEaseInToSlowEaseOut),
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
                    hintText: 'fieldChatMessage'.tr(args: [
                      widget.controller.channel?.name ?? 'loading'.tr()
                    ]),
                    border: InputBorder.none,
                  ),
                  onTapOutside: (_) =>
                      FocusManager.instance.primaryFocus?.unfocus(),
                  onSubmitted: (_) {
                    if (_isBusy) return;
                    _sendMessage();
                    _focusNode.requestFocus();
                  },
                ),
              ),
              const Gap(8),
              PopupMenuButton(
                icon: Icon(
                  Symbols.add_photo_alternate,
                  color: Theme.of(context).colorScheme.primary,
                ),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Row(
                      children: [
                        const Icon(Symbols.photo_library),
                        const Gap(16),
                        Text('addAttachmentFromAlbum').tr(),
                      ],
                    ),
                    onTap: () {
                      _selectMedia();
                    },
                  ),
                  PopupMenuItem(
                    child: Row(
                      children: [
                        const Icon(Symbols.content_paste),
                        const Gap(16),
                        Text('addAttachmentFromClipboard').tr(),
                      ],
                    ),
                    onTap: () {
                      _pasteMedia();
                    },
                  ),
                ],
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
