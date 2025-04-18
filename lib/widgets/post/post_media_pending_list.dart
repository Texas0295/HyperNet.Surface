// ignore_for_file: unused_import

import 'dart:io';
import 'dart:ui';

import 'package:croppy/croppy.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_context_menu/flutter_context_menu.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:pasteboard/pasteboard.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:surface/controllers/post_write_controller.dart';
import 'package:surface/providers/sn_attachment.dart';
import 'package:surface/providers/sn_network.dart';
import 'package:surface/types/attachment.dart';
import 'package:surface/widgets/attachment/attachment_input.dart';
import 'package:surface/widgets/attachment/attachment_zoom.dart';
import 'package:surface/widgets/attachment/pending_attachment_actions.dart';
import 'package:surface/widgets/attachment/pending_attachment_alt.dart';
import 'package:surface/widgets/attachment/pending_attachment_boost.dart';
import 'package:surface/widgets/dialog.dart';
import 'package:surface/widgets/universal_image.dart';

import '../attachment/pending_attachment_compress.dart';

class PostMediaPendingList extends StatelessWidget {
  final List<PostWriteMedia> attachments;
  final bool isBusy;
  final Future<void> Function(int idx, PostWriteMedia updatedMedia)? onUpdate;
  final Future<void> Function(int idx)? onRemove;
  final Future<void> Function(int idx)? onUpload;
  final void Function(int idx)? onInsertLink;
  final void Function(bool state)? onUpdateBusy;

  const PostMediaPendingList({
    super.key,
    required this.attachments,
    required this.isBusy,
    this.onUpdate,
    this.onRemove,
    this.onUpload,
    this.onInsertLink,
    this.onUpdateBusy,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 120),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        separatorBuilder: (context, index) => const Gap(8),
        itemCount: attachments.length,
        itemBuilder: (context, idx) {
          final media = attachments[idx];
          return GestureDetector(
            child: _PostMediaPendingItem(media: media),
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => PendingAttachmentActionSheet(
                  media: media,
                ),
              ).then((value) async {
                if (value is PostWriteMedia) {
                  await onUpdate!(idx, value);
                }
                if (value == 'link') {
                  onInsertLink!(idx);
                } else if (value == false) {
                  onRemove!(idx);
                } else if (value == true) {
                  onUpload!(idx);
                }
              });
            },
          );
        },
      ),
    );
  }
}

class _PostMediaPendingItem extends StatelessWidget {
  final PostWriteMedia media;

  const _PostMediaPendingItem({required this.media});

  @override
  Widget build(BuildContext context) {
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;

    final sn = context.read<SnNetworkProvider>();

    return Material(
      elevation: 4,
      color: Theme.of(context).colorScheme.surfaceContainer,
      borderRadius: BorderRadius.circular(8),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: switch (media.type) {
                SnMediaType.image => LayoutBuilder(
                    builder: (context, constraints) {
                      return Image(
                        image: media.getImageProvider(
                          context,
                          width:
                              (constraints.maxWidth * devicePixelRatio).round(),
                          height: (constraints.maxHeight * devicePixelRatio)
                              .round(),
                        )!,
                        fit: BoxFit.contain,
                      );
                    },
                  ),
                SnMediaType.video => Stack(
                    fit: StackFit.expand,
                    children: [
                      if (media.attachment?.thumbnail != null)
                        AutoResizeUniversalImage(sn.getAttachmentUrl(
                            media.attachment!.thumbnail!.rid)),
                      const Icon(
                        Symbols.videocam,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                              offset: Offset(1, 1),
                              blurRadius: 8.0,
                              color: Color.fromARGB(255, 0, 0, 0))
                        ],
                      ),
                    ],
                  ),
                SnMediaType.audio => Stack(
                    fit: StackFit.expand,
                    children: [
                      if (media.attachment?.thumbnail != null)
                        AutoResizeUniversalImage(sn.getAttachmentUrl(
                            media.attachment!.thumbnail!.rid)),
                      const Icon(
                        Symbols.audio_file,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                              offset: Offset(1, 1),
                              blurRadius: 8.0,
                              color: Color.fromARGB(255, 0, 0, 0))
                        ],
                      ),
                    ],
                  ),
                _ => Container(
                    color: Theme.of(context).colorScheme.surfaceContainer,
                    child: const Icon(Symbols.docs).center(),
                  ),
              },
            ),
            if (media.type != SnMediaType.image)
              const VerticalDivider(width: 1, thickness: 1),
            if (media.type != SnMediaType.image)
              SizedBox(
                width: 160,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (media.attachment != null)
                            Text(media.attachment!.alt,
                                maxLines: 1, overflow: TextOverflow.ellipsis)
                          else if (media.file != null)
                            Text(media.file!.name,
                                maxLines: 1, overflow: TextOverflow.ellipsis)
                          else
                            Text('unknown'.tr()),
                          if (media.attachment != null)
                            Text(
                              media.attachment!.size.formatBytes(),
                              style: GoogleFonts.robotoMono(fontSize: 13),
                              maxLines: 1,
                            )
                          else if (media.file != null)
                            FutureBuilder<int?>(
                              future: media.length(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return const SizedBox.shrink();
                                }
                                return Text(
                                  snapshot.data!.formatBytes(),
                                  style: GoogleFonts.robotoMono(fontSize: 13),
                                  maxLines: 1,
                                );
                              },
                            ),
                        ],
                      ),
                    ),
                    if (media.attachment != null &&
                        media.attachment!.boosts.isNotEmpty)
                      Row(
                        children: [
                          Icon(Symbols.bolt, size: 16),
                          const Gap(4),
                          Text('attachmentGotBoosted').tr().fontSize(13),
                        ],
                      ),
                    if (media.attachment != null &&
                        media.attachment!.compressedId != null)
                      Row(
                        children: [
                          Icon(Symbols.compress, size: 16),
                          const Gap(4),
                          Text('attachmentCopyCompressed').tr().fontSize(13),
                        ],
                      ),
                    if (media.attachment != null)
                      Row(
                        children: [
                          Icon(Symbols.cloud, size: 16),
                          const Gap(4),
                          Text('attachmentUploaded').tr().fontSize(13),
                        ],
                      )
                    else
                      Row(
                        children: [
                          Icon(Symbols.cloud_off, size: 16),
                          const Gap(4),
                          Text('attachmentPending').tr().fontSize(13),
                        ],
                      ),
                  ],
                ),
              ).padding(horizontal: 12, vertical: 12),
          ],
        ),
      ),
    );
  }
}

class AddPostMediaButton extends StatelessWidget {
  final VisualDensity? visualDensity;
  final Function(Iterable<PostWriteMedia>) onAdd;

  const AddPostMediaButton(
      {super.key, required this.onAdd, this.visualDensity});

  void _takeMedia(bool isVideo) async {
    final picker = ImagePicker();
    final result = isVideo
        ? await picker.pickVideo(source: ImageSource.camera)
        : await picker.pickImage(source: ImageSource.camera);
    if (result == null) return;
    onAdd([PostWriteMedia.fromFile(result)]);
  }

  void _selectMedia() async {
    final picker = ImagePicker();
    final result = await picker.pickMultipleMedia();
    if (result.isEmpty) return;
    onAdd(result.map((e) => PostWriteMedia.fromFile(e)));
  }

  void _selectFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.any);
    if (result == null) return;
    onAdd(result.files.map((e) => PostWriteMedia.fromFile(e.xFile)));
  }

  void _pasteMedia() async {
    final imageBytes = await Pasteboard.image;
    if (imageBytes == null) return;
    onAdd([
      PostWriteMedia.fromBytes(
          imageBytes, 'attachmentPastedImage'.tr(), SnMediaType.image)
    ]);
  }

  void _linkRandomId(BuildContext context) async {
    final randomIdController = TextEditingController();
    final randomId = await showDialog<String?>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('addAttachmentFromRandomId').tr(),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: randomIdController,
              decoration: InputDecoration(
                labelText: 'fieldAttachmentRandomId'.tr(),
                border: const UnderlineInputBorder(),
              ),
            ),
            const Gap(8),
          ],
        ),
        actions: [
          TextButton(
            child: Text('dialogDismiss').tr(),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: Text('dialogConfirm').tr(),
            onPressed: () {
              Navigator.pop(context, randomIdController.text);
            },
          ),
        ],
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      randomIdController.dispose();
    });
    if (randomId == null || randomId.isEmpty) return;
    if (!context.mounted) return;

    final attach = context.read<SnAttachmentProvider>();
    final attachment = await attach.getOne(randomId);

    onAdd([PostWriteMedia(attachment)]);
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      style: ButtonStyle(visualDensity: visualDensity),
      icon: Icon(Symbols.add_photo_alternate,
          color: Theme.of(context).colorScheme.primary),
      itemBuilder: (context) => [
        if (!kIsWeb &&
            !Platform.isLinux &&
            !Platform.isMacOS &&
            !Platform.isWindows)
          PopupMenuItem(
            child: Row(
              children: [
                const Icon(Symbols.photo_camera),
                const Gap(16),
                Text('addAttachmentFromCameraPhoto').tr(),
              ],
            ),
            onTap: () {
              _takeMedia(false);
            },
          ),
        if (!kIsWeb &&
            !Platform.isLinux &&
            !Platform.isMacOS &&
            !Platform.isWindows)
          PopupMenuItem(
            child: Row(
              children: [
                const Icon(Symbols.videocam),
                const Gap(16),
                Text('addAttachmentFromCameraVideo').tr()
              ],
            ),
            onTap: () {
              _takeMedia(true);
            },
          ),
        PopupMenuItem(
          child: Row(
            children: [
              const Icon(Symbols.photo_library),
              const Gap(16),
              Text('addAttachmentFromAlbum').tr()
            ],
          ),
          onTap: () {
            _selectMedia();
          },
        ),
        PopupMenuItem(
          child: Row(
            children: [
              const Icon(Symbols.file_upload),
              const Gap(16),
              Text('addAttachmentFromFiles').tr()
            ],
          ),
          onTap: () {
            _selectFile();
          },
        ),
        PopupMenuItem(
          child: Row(children: [
            const Icon(Symbols.link),
            const Gap(16),
            Text('addAttachmentFromRandomId').tr()
          ]),
          onTap: () {
            _linkRandomId(context);
          },
        ),
        PopupMenuItem(
          child: Row(
            children: [
              const Icon(Symbols.content_paste),
              const Gap(16),
              Text('addAttachmentFromClipboard').tr()
            ],
          ),
          onTap: () {
            _pasteMedia();
          },
        ),
      ],
    );
  }
}
