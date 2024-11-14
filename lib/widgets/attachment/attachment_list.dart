import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:surface/types/attachment.dart';
import 'package:surface/widgets/attachment/attachment_item.dart';

class AttachmentList extends StatelessWidget {
  final List<SnAttachment> data;
  final bool? bordered;
  final double? maxHeight;
  final EdgeInsets? listPadding;
  const AttachmentList({
    super.key,
    required this.data,
    this.bordered,
    this.maxHeight,
    this.listPadding,
  });

  static const BorderRadius kDefaultRadius =
      BorderRadius.all(Radius.circular(8));

  @override
  Widget build(BuildContext context) {
    final borderSide = (bordered ?? false)
        ? BorderSide(width: 1, color: Theme.of(context).dividerColor)
        : BorderSide.none;
    final backgroundColor = Theme.of(context).colorScheme.surfaceContainer;
    final constraints = BoxConstraints(
      minWidth: 80,
      maxHeight: maxHeight ?? double.infinity,
    );

    if (data.isEmpty) return const SizedBox.shrink();
    if (data.length == 1) {
      if (ResponsiveBreakpoints.of(context).largerThan(MOBILE)) {
        return Padding(
          // Single child list-like displaying
          padding: listPadding ?? EdgeInsets.zero,
          child: Container(
            constraints: constraints,
            decoration: BoxDecoration(
              color: backgroundColor,
              border: Border(top: borderSide, bottom: borderSide),
              borderRadius: kDefaultRadius,
            ),
            child: AspectRatio(
              aspectRatio: data[0].metadata['ratio']?.toDouble() ?? 1,
              child: ClipRRect(
                borderRadius: kDefaultRadius,
                child: AttachmentItem(data: data[0], isExpandable: true),
              ),
            ),
          ),
        );
      }

      return Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border(top: borderSide, bottom: borderSide),
        ),
        child: AspectRatio(
          aspectRatio: data[0].metadata['ratio']?.toDouble() ?? 1,
          child: AttachmentItem(data: data[0], isExpandable: true),
        ),
      );
    }

    return Container(
      constraints: BoxConstraints(maxHeight: maxHeight ?? 320),
      child: ScrollConfiguration(
        behavior: _AttachmentListScrollBehavior(),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (context, idx) {
            return Stack(
              children: [
                Container(
                  constraints: constraints,
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    border: Border(top: borderSide, bottom: borderSide),
                    borderRadius: kDefaultRadius,
                  ),
                  child: AspectRatio(
                    aspectRatio: data[idx].metadata['ratio']?.toDouble() ?? 1,
                    child: ClipRRect(
                      borderRadius: kDefaultRadius,
                      child:
                          AttachmentItem(data: data[idx], isExpandable: true),
                    ),
                  ),
                ),
                Positioned(
                  right: 12,
                  bottom: 12,
                  child: Chip(
                    label: Text('${idx + 1}/${data.length}'),
                  ),
                ),
              ],
            );
          },
          separatorBuilder: (context, index) => const Gap(8),
          padding: listPadding,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }
}

class _AttachmentListScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
