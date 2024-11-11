import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
          child: LayoutBuilder(builder: (context, constraints) {
            return UniversalImage(
              sn.getAttachmentUrl(data.rid),
              key: Key('attachment-${data.rid}-$heroTag'),
              fit: BoxFit.cover,
              cacheHeight: constraints.maxHeight,
              cacheWidth: constraints.maxWidth,
            );
          }),
        );
      default:
        return const Placeholder();
    }
  }

  @override
  Widget build(BuildContext context) {
    final uuid = Uuid();
    final heroTag = uuid.v4();

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
