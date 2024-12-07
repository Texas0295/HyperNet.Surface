import 'dart:io';
import 'dart:ui';

import 'package:croppy/croppy.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_context_menu/flutter_context_menu.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:surface/controllers/post_write_controller.dart';
import 'package:surface/providers/sn_network.dart';
import 'package:surface/widgets/attachment/attachment_zoom.dart';
import 'package:surface/widgets/dialog.dart';

class PostMediaPendingList extends StatelessWidget {
  final PostWriteMedia? thumbnail;
  final List<PostWriteMedia> attachments;
  final bool isBusy;
  final Future<void> Function(int idx, PostWriteMedia updatedMedia)? onUpdate;
  final Future<void> Function(int idx)? onRemove;
  final Future<void> Function(int idx)? onUpload;
  final void Function(int? idx)? onPostSetThumbnail;
  final void Function(int idx)? onInsertLink;
  final void Function(bool state)? onUpdateBusy;

  const PostMediaPendingList({
    super.key,
    this.thumbnail,
    required this.attachments,
    required this.isBusy,
    this.onUpdate,
    this.onRemove,
    this.onUpload,
    this.onPostSetThumbnail,
    this.onInsertLink,
    this.onUpdateBusy,
  });

  Future<void> _cropImage(BuildContext context, int idx) async {
    final media = attachments[idx];
    final result = (!kIsWeb && (Platform.isIOS || Platform.isMacOS))
        ? await showCupertinoImageCropper(
            // ignore: use_build_context_synchronously
            context,
            // ignore: use_build_context_synchronously
            imageProvider: media.getImageProvider(context)!,
          )
        : await showMaterialImageCropper(
            // ignore: use_build_context_synchronously
            context,
            // ignore: use_build_context_synchronously
            imageProvider: media.getImageProvider(context)!,
          );

    if (result == null) return;

    final rawBytes = (await result.uiImage.toByteData(format: ImageByteFormat.png))!.buffer.asUint8List();

    if (onUpdate != null) {
      final updatedMedia = PostWriteMedia.fromBytes(
        rawBytes,
        media.name,
        media.type,
      );
      await onUpdate!(idx, updatedMedia);
    }
  }

  Future<void> _deleteAttachment(BuildContext context, int idx) async {
    final media = idx == -1 ? thumbnail! : attachments[idx];
    if (media.attachment == null) return;

    try {
      onUpdateBusy?.call(true);
      final sn = context.read<SnNetworkProvider>();
      await sn.client.delete('/cgi/uc/attachments/${media.attachment!.id}');
      onRemove!(idx);
    } catch (err) {
      if (!context.mounted) return;
      context.showErrorDialog(err);
    } finally {
      onUpdateBusy?.call(false);
    }
  }

  ContextMenu _buildContextMenu(BuildContext context, int idx, PostWriteMedia media) {
    return ContextMenu(
      entries: [
        if (media.attachment == null && onUpload != null)
          MenuItem(
              label: 'attachmentUpload'.tr(),
              icon: Symbols.upload,
              onSelected: () {
                onUpload!(idx);
              }),
        if (media.attachment != null && onPostSetThumbnail != null && idx != -1)
          MenuItem(
            label: 'attachmentSetAsPostThumbnail'.tr(),
            icon: Symbols.gallery_thumbnail,
            onSelected: () {
              onPostSetThumbnail!(idx);
            },
          )
        else if (media.attachment != null && onPostSetThumbnail != null)
          MenuItem(
            label: 'attachmentUnsetAsPostThumbnail'.tr(),
            icon: Symbols.cancel,
            onSelected: () {
              onPostSetThumbnail!(null);
            },
          ),
        if (media.attachment != null && onInsertLink != null)
          MenuItem(
            label: 'attachmentInsertLink'.tr(),
            icon: Symbols.add_link,
            onSelected: () {
              onInsertLink!(idx);
            },
          ),
        if (media.type == PostWriteMediaType.image && media.attachment != null)
          MenuItem(
            label: 'preview'.tr(),
            icon: Symbols.preview,
            onSelected: () {
              context.pushTransparentRoute(
                AttachmentZoomView(data: [media.attachment!]),
                rootNavigator: true,
              );
            },
          ),
        if (media.type == PostWriteMediaType.image && media.attachment == null)
          MenuItem(
            label: 'crop'.tr(),
            icon: Symbols.crop,
            onSelected: () => _cropImage(context, idx),
          ),
        if (media.attachment != null && onRemove != null)
          MenuItem(
            label: 'delete'.tr(),
            icon: Symbols.delete,
            onSelected: isBusy ? null : () => _deleteAttachment(context, idx),
          ),
        if (media.attachment == null && onRemove != null)
          MenuItem(
            label: 'delete'.tr(),
            icon: Symbols.delete,
            onSelected: () {
              onRemove!(idx);
            },
          )
        else if (onRemove != null)
          MenuItem(
            label: 'unlink'.tr(),
            icon: Symbols.link_off,
            onSelected: () {
              onRemove!(idx);
            },
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;

    return Container(
      constraints: const BoxConstraints(maxHeight: 120),
      child: Row(
        children: [
          const Gap(8),
          if (thumbnail != null)
            ContextMenuRegion(
              contextMenu: _buildContextMenu(context, -1, thumbnail!),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).dividerColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: switch (thumbnail!.type) {
                      PostWriteMediaType.image => LayoutBuilder(builder: (context, constraints) {
                          return Image(
                            image: thumbnail!.getImageProvider(
                              context,
                              width: (constraints.maxWidth * devicePixelRatio).round(),
                              height: (constraints.maxHeight * devicePixelRatio).round(),
                            )!,
                            fit: BoxFit.cover,
                          );
                        }),
                      _ => Container(
                          color: Theme.of(context).colorScheme.surface,
                          child: const Icon(Symbols.docs).center(),
                        ),
                    },
                  ),
                ),
              ),
            ),
          if (thumbnail != null)
            const VerticalDivider(width: 1, thickness: 1).padding(
              horizontal: 12,
              vertical: 16,
            ),
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(right: 8),
              separatorBuilder: (context, index) => const Gap(8),
              itemCount: attachments.length,
              itemBuilder: (context, idx) {
                final media = attachments[idx];
                return ContextMenuRegion(
                  contextMenu: _buildContextMenu(context, idx, media),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).dividerColor,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: switch (media.type) {
                          PostWriteMediaType.image => LayoutBuilder(builder: (context, constraints) {
                              return Image(
                                image: media.getImageProvider(
                                  context,
                                  width: (constraints.maxWidth * devicePixelRatio).round(),
                                  height: (constraints.maxHeight * devicePixelRatio).round(),
                                )!,
                                fit: BoxFit.cover,
                              );
                            }),
                          _ => Container(
                              color: Theme.of(context).colorScheme.surface,
                              child: const Icon(Symbols.docs).center(),
                            ),
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
