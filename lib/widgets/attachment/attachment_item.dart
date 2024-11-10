import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surface/providers/sn_network.dart';
import 'package:surface/types/attachment.dart';
import 'package:surface/widgets/universal_image.dart';

class AttachmentItem extends StatelessWidget {
  final SnAttachment data;
  const AttachmentItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final tp = data.mimetype.split('/').firstOrNull;
    final sn = context.read<SnNetworkProvider>();
    switch (tp) {
      case 'image':
        return UniversalImage(
          sn.getAttachmentUrl(data.rid),
          fit: BoxFit.cover,
        );
      default:
        return const Placeholder();
    }
  }
}
