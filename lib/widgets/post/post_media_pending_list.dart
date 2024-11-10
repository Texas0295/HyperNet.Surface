import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_context_menu/flutter_context_menu.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';

class PostMediaPendingList extends StatelessWidget {
  final List<XFile> data;
  final Function(int idx)? onRemove;
  const PostMediaPendingList({
    super.key,
    required this.data,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
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
                  child: kIsWeb
                      ? Image.network(file.path, fit: BoxFit.cover)
                      : Image.file(File(file.path), fit: BoxFit.cover),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
