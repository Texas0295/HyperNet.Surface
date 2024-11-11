import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_context_menu/flutter_context_menu.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:surface/controllers/post_write_controller.dart';

class PostMediaPendingList extends StatelessWidget {
  final List<PostWriteMedia> data;
  final Function(int idx)? onRemove;
  const PostMediaPendingList({
    super.key,
    required this.data,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;

    return Container(
      constraints: const BoxConstraints(maxHeight: 120),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        separatorBuilder: (context, index) => const Gap(8),
        itemCount: data.length,
        itemBuilder: (context, idx) {
          final file = data[idx];
          return ContextMenuRegion(
            contextMenu: ContextMenu(
              entries: [
                if (onRemove != null)
                  MenuItem(
                    label: 'delete'.tr(),
                    icon: Symbols.delete,
                    onSelected: () {
                      onRemove!(idx);
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
                  child: switch (file.type) {
                    PostWriteMediaType.image =>
                      LayoutBuilder(builder: (context, constraints) {
                        return Image(
                          image: file.getImageProvider(
                            context,
                            width: (constraints.maxWidth * devicePixelRatio)
                                .round(),
                            height: (constraints.maxHeight * devicePixelRatio)
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
  }
}
