import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:surface/providers/sn_network.dart';
import 'package:surface/types/attachment.dart';
import 'package:surface/widgets/universal_image.dart';
import 'package:uuid/uuid.dart';

class AttachmentDetailPopup extends StatelessWidget {
  final SnAttachment data;
  final String? heroTag;
  const AttachmentDetailPopup({super.key, required this.data, this.heroTag});

  @override
  Widget build(BuildContext context) {
    final sn = context.read<SnNetworkProvider>();
    final uuid = Uuid();

    return DismissiblePage(
      onDismissed: () {
        Navigator.of(context).pop();
      },
      direction: DismissiblePageDismissDirection.down,
      backgroundColor: Colors.transparent,
      isFullScreen: true,
      child: Hero(
        tag: 'attachment-${data.rid}-${heroTag ?? uuid.v4()}',
        child: PhotoView(
          imageProvider: UniversalImage.provider(
            sn.getAttachmentUrl(data.rid),
          ),
        ),
      ),
    );
  }
}
