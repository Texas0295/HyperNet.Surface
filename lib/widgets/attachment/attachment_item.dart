import 'dart:ui';

import 'package:dismissible_page/dismissible_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:surface/providers/sn_network.dart';
import 'package:surface/types/attachment.dart';
import 'package:surface/widgets/attachment/attachment_detail.dart';
import 'package:surface/widgets/universal_image.dart';
import 'package:uuid/uuid.dart';

class AttachmentItem extends StatelessWidget {
  final SnAttachment data;
  final bool isExpandable;
  const AttachmentItem({
    super.key,
    required this.data,
    this.isExpandable = false,
  });

  Widget _buildContent(BuildContext context, String heroTag) {
    final tp = data.mimetype.split('/').firstOrNull;
    final sn = context.read<SnNetworkProvider>();
    switch (tp) {
      case 'image':
        return Hero(
          tag: 'attachment-${data.rid}-$heroTag',
          child: AutoResizeUniversalImage(
            sn.getAttachmentUrl(data.rid),
            key: Key('attachment-${data.rid}-$heroTag'),
            fit: BoxFit.cover,
          ),
        );
      default:
        return const Placeholder();
    }
  }

  @override
  Widget build(BuildContext context) {
    final uuid = Uuid();
    final heroTag = uuid.v4();

    if (data.isMature) {
      return _AttachmentItemSensitiveBlur(
        child: _buildContent(context, heroTag),
      );
    }

    if (isExpandable) {
      return GestureDetector(
        child: _buildContent(context, heroTag),
        onTap: () {
          context.pushTransparentRoute(
            AttachmentDetailPopup(data: data, heroTag: heroTag),
            rootNavigator: true,
          );
        },
      );
    }

    return _buildContent(context, heroTag);
  }
}

class _AttachmentItemSensitiveBlur extends StatefulWidget {
  final Widget child;
  const _AttachmentItemSensitiveBlur({super.key, required this.child});

  @override
  State<_AttachmentItemSensitiveBlur> createState() =>
      _AttachmentItemSensitiveBlurState();
}

class _AttachmentItemSensitiveBlurState
    extends State<_AttachmentItemSensitiveBlur> {
  bool _doesShow = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
            child: Container(
              color: Colors.black.withOpacity(0.5),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Symbols.visibility_off,
                    color: Colors.white,
                    size: 32,
                  ),
                  const Gap(8),
                  Text('sensitiveContent')
                      .tr()
                      .fontSize(20)
                      .textColor(Colors.white)
                      .bold(),
                  Text('sensitiveContentDescription')
                      .tr()
                      .fontSize(14)
                      .textColor(Colors.white.withOpacity(0.8)),
                  const Gap(16),
                  InkWell(
                    child: Text('sensitiveContentReveal')
                        .tr()
                        .textColor(Colors.white),
                    onTap: () {
                      setState(() => _doesShow = !_doesShow);
                    },
                  ),
                ],
              ),
            ),
          ),
        )
            .opacity(_doesShow ? 0 : 1, animate: true)
            .animate(const Duration(milliseconds: 300), Curves.easeInOut),
        if (_doesShow)
          Positioned(
            top: 0,
            left: 0,
            child: InkWell(
              child: Icon(
                Symbols.visibility_off,
                color: Colors.white,
                shadows: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 3,
                    offset: Offset(0, 1.5),
                  ),
                ],
              ).padding(all: 12),
              onTap: () {
                setState(() => _doesShow = !_doesShow);
              },
            ),
          ),
      ],
    );
  }
}
