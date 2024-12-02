import 'dart:math' as math;

import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:surface/types/attachment.dart';
import 'package:surface/widgets/attachment/attachment_detail.dart';
import 'package:surface/widgets/attachment/attachment_item.dart';
import 'package:uuid/uuid.dart';

class AttachmentList extends StatefulWidget {
  final List<SnAttachment?> data;
  final bool bordered;
  final bool noGrow;
  final double? maxHeight;
  final EdgeInsets? listPadding;
  const AttachmentList({
    super.key,
    required this.data,
    this.bordered = false,
    this.noGrow = false,
    this.maxHeight,
    this.listPadding,
  });

  static const BorderRadius kDefaultRadius =
      BorderRadius.all(Radius.circular(8));

  @override
  State<AttachmentList> createState() => _AttachmentListState();
}

class _AttachmentListState extends State<AttachmentList> {
  late final List<String> heroTags = List.generate(
    widget.data.length,
    (_) => const Uuid().v4(),
  );

  static const double kAttachmentMaxWidth = 640;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, layoutConstraints) {
        final borderSide = widget.bordered
            ? BorderSide(width: 1, color: Theme.of(context).dividerColor)
            : BorderSide.none;
        final backgroundColor = Theme.of(context).colorScheme.surfaceContainer;
        final constraints = BoxConstraints(
          minWidth: 80,
          maxHeight: widget.maxHeight ?? double.infinity,
          maxWidth: layoutConstraints.maxWidth - 20,
        );

        if (widget.data.isEmpty) return const SizedBox.shrink();
        if (widget.data.length == 1) {
          final singleAspectRatio =
              widget.data[0]?.metadata['ratio']?.toDouble() ??
                  switch (widget.data[0]?.mimetype.split('/').firstOrNull) {
                    'audio' => 16 / 9,
                    'video' => 16 / 9,
                    _ => 1,
                  };

          return Container(
            constraints: ResponsiveBreakpoints.of(context).largerThan(MOBILE)
                ? constraints.copyWith(
                    maxWidth: math.min(
                      constraints.maxWidth,
                      kAttachmentMaxWidth,
                    ),
                  )
                : null,
            child: AspectRatio(
              aspectRatio: singleAspectRatio,
              child: GestureDetector(
                child: Builder(
                  builder: (context) {
                    if (ResponsiveBreakpoints.of(context).largerThan(MOBILE) ||
                        widget.noGrow) {
                      return Padding(
                        // Single child list-like displaying
                        padding: widget.listPadding ?? EdgeInsets.zero,
                        child: Container(
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            border: Border(top: borderSide, bottom: borderSide),
                            borderRadius: AttachmentList.kDefaultRadius,
                          ),
                          child: ClipRRect(
                            borderRadius: AttachmentList.kDefaultRadius,
                            child: AttachmentItem(
                              data: widget.data[0],
                              heroTag: heroTags[0],
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
                      child: AttachmentItem(
                        data: widget.data[0],
                        heroTag: heroTags.first,
                      ),
                    );
                  },
                ),
                onTap: () {
                  context.pushTransparentRoute(
                    AttachmentZoomView(
                      data: widget.data.where((ele) => ele != null).cast(),
                      initialIndex: 0,
                      heroTags: heroTags,
                    ),
                    backgroundColor: Colors.black.withOpacity(0.7),
                    rootNavigator: true,
                  );
                },
              ),
            ),
          );
        }

        return AspectRatio(
          aspectRatio: widget.data.firstOrNull?.metadata['ratio'] ?? 1,
          child: Container(
            constraints: BoxConstraints(maxHeight: constraints.maxHeight),
            child: ScrollConfiguration(
              behavior: _AttachmentListScrollBehavior(),
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: widget.data.length,
                itemBuilder: (context, idx) {
                  return Container(
                    constraints: constraints,
                    child: AspectRatio(
                      aspectRatio: widget.data[idx]?.metadata['ratio'] ?? 1,
                      child: GestureDetector(
                        onTap: () {
                          context.pushTransparentRoute(
                            AttachmentZoomView(
                              data: widget.data
                                  .where((ele) => ele != null)
                                  .cast(),
                              initialIndex: idx,
                              heroTags: heroTags,
                            ),
                            backgroundColor: Colors.black.withOpacity(0.7),
                            rootNavigator: true,
                          );
                        },
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: backgroundColor,
                                border: Border(
                                  top: borderSide,
                                  bottom: borderSide,
                                ),
                                borderRadius: AttachmentList.kDefaultRadius,
                              ),
                              child: ClipRRect(
                                borderRadius: AttachmentList.kDefaultRadius,
                                child: AttachmentItem(
                                  data: widget.data[idx],
                                  heroTag: heroTags[idx],
                                ),
                              ),
                            ),
                            Positioned(
                              right: 8,
                              bottom: 8,
                              child: Chip(
                                label: Text('${idx + 1}/${widget.data.length}'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Gap(8),
                padding: widget.listPadding,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),
        );
      },
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
