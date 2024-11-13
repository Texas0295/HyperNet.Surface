import 'dart:math' as math;

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
  const AttachmentList({
    super.key,
    required this.data,
    this.bordered,
    this.maxHeight,
  });

  static const double kMaxItemWidth = 520;
  static const BorderRadius kDefaultRadius =
      BorderRadius.all(Radius.circular(8));

  @override
  Widget build(BuildContext context) {
    final borderSide = (bordered ?? false)
        ? BorderSide(width: 1, color: Theme.of(context).dividerColor)
        : BorderSide.none;

    if (data.isEmpty) return const SizedBox.shrink();
    if (data.length == 1) {
      if (ResponsiveBreakpoints.of(context).largerThan(MOBILE)) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: maxHeight ?? double.infinity,
            maxWidth: math.min(
              MediaQuery.of(context).size.width - 20,
              kMaxItemWidth,
            ),
          ),
          decoration: BoxDecoration(
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
        );
      }

      return Container(
        decoration: BoxDecoration(
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
            return Container(
              constraints: BoxConstraints(
                maxHeight: maxHeight ?? double.infinity,
                maxWidth: math.min(
                  MediaQuery.of(context).size.width - 20,
                  kMaxItemWidth,
                ),
              ),
              decoration: BoxDecoration(
                border: Border(top: borderSide, bottom: borderSide),
                borderRadius: kDefaultRadius,
              ),
              child: AspectRatio(
                aspectRatio: data[idx].metadata['ratio']?.toDouble() ?? 1,
                child: ClipRRect(
                  borderRadius: kDefaultRadius,
                  child: AttachmentItem(data: data[idx], isExpandable: true),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => const Gap(8),
          padding: const EdgeInsets.symmetric(horizontal: 12),
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
