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
import 'package:styled_widget/styled_widget.dart';
import 'package:surface/controllers/post_write_controller.dart';
import 'package:surface/widgets/attachment/attachment_detail.dart';

class PostMediaPendingList extends StatelessWidget {
  final PostWriteController controller;
  const PostMediaPendingList({super.key, required this.controller});

  void _cropImage(BuildContext context, int idx) async {
    final media = controller.attachments[idx];
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
    if (!context.mounted) return;

    final rawBytes =
        (await result.uiImage.toByteData(format: ImageByteFormat.png))!
            .buffer
            .asUint8List();
    controller.setAttachmentAt(
      idx,
      PostWriteMedia.fromBytes(rawBytes, media.name, media.type),
    );
  }

  @override
  Widget build(BuildContext context) {
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;

    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        return Container(
          constraints: const BoxConstraints(maxHeight: 120),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            separatorBuilder: (context, index) => const Gap(8),
            itemCount: controller.attachments.length,
            itemBuilder: (context, idx) {
              final media = controller.attachments[idx];
              return ContextMenuRegion(
                contextMenu: ContextMenu(
                  entries: [
                    if (media.type == PostWriteMediaType.image &&
                        media.attachment != null)
                      MenuItem(
                        label: 'preview'.tr(),
                        icon: Symbols.preview,
                        onSelected: () {
                          context.pushTransparentRoute(
                            AttachmentDetailPopup(data: media.attachment!),
                            rootNavigator: true,
                          );
                        },
                      ),
                    if (media.type == PostWriteMediaType.image &&
                        media.attachment == null)
                      MenuItem(
                        label: 'crop'.tr(),
                        icon: Symbols.crop,
                        onSelected: () => _cropImage(context, idx),
                      ),
                    if (media.attachment == null)
                      MenuItem(
                        label: 'delete'.tr(),
                        icon: Symbols.delete,
                        onSelected: () {
                          controller.removeAttachmentAt(idx);
                        },
                      )
                    else
                      MenuItem(
                        label: 'unlink'.tr(),
                        icon: Symbols.link_off,
                        onSelected: () {
                          controller.removeAttachmentAt(idx);
                        },
                      ),
                  ],
                ),
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
                        PostWriteMediaType.image =>
                          LayoutBuilder(builder: (context, constraints) {
                            return Image(
                              image: media.getImageProvider(
                                context,
                                width: (constraints.maxWidth * devicePixelRatio)
                                    .round(),
                                height:
                                    (constraints.maxHeight * devicePixelRatio)
                                        .round(),
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
        );
      },
    );
  }
}
