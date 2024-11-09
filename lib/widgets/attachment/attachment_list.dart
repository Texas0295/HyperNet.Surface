import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:surface/types/attachment.dart';
import 'package:surface/widgets/attachment/attachment_item.dart';

class AttachmentList extends StatelessWidget {
  final List<SnAttachment> data;
  final bool? bordered;
  final double? maxListHeight;
  const AttachmentList(
      {super.key, required this.data, this.bordered, this.maxListHeight});

  @override
  Widget build(BuildContext context) {
    final borderSide = (bordered ?? false)
        ? BorderSide(width: 1, color: Theme.of(context).dividerColor)
        : BorderSide.none;

    if (data.isEmpty) return const SizedBox.shrink();
    if (data.length == 1) {
      return Container(
        decoration: BoxDecoration(
          border: Border(top: borderSide, bottom: borderSide),
        ),
        child: AttachmentItem(data: data[0]),
      );
    }

    return Container(
      constraints: BoxConstraints(maxHeight: maxListHeight ?? 320),
      child: ScrollConfiguration(
        behavior: _AttachmentListScrollBehavior(),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (context, idx) {
            const radius = BorderRadius.all(Radius.circular(8));
            return Container(
              decoration: BoxDecoration(
                border: Border(top: borderSide, bottom: borderSide),
                borderRadius: radius,
              ),
              child: ClipRRect(
                borderRadius: radius,
                child: AttachmentItem(data: data[idx]),
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
