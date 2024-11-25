import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';
import 'package:surface/providers/sn_network.dart';
import 'package:surface/types/attachment.dart';
import 'package:surface/widgets/universal_image.dart';
import 'package:uuid/uuid.dart';

class AttachmentZoomView extends StatefulWidget {
  final Iterable<SnAttachment> data;
  final int? initialIndex;
  final List<String?>? heroTags;
  const AttachmentZoomView({
    super.key,
    required this.data,
    this.initialIndex,
    this.heroTags,
  });

  @override
  State<AttachmentZoomView> createState() => _AttachmentZoomViewState();
}

class _AttachmentZoomViewState extends State<AttachmentZoomView> {
  late final PageController _pageController =
      PageController(initialPage: widget.initialIndex ?? 0);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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
      child: Builder(builder: (context) {
        if (widget.data.length == 1) {
          final heroTag = widget.heroTags?.first ?? uuid.v4();
          return Hero(
            tag: 'attachment-${widget.data.first.rid}-$heroTag',
            child: PhotoView(
              key: Key('attachment-detail-${widget.data.first.rid}-$heroTag'),
              backgroundDecoration: BoxDecoration(color: Colors.transparent),
              imageProvider: UniversalImage.provider(
                sn.getAttachmentUrl(widget.data.first.rid),
              ),
            ),
          );
        }

        return PhotoViewGallery.builder(
          pageController: _pageController,
          scrollPhysics: const BouncingScrollPhysics(),
          builder: (context, idx) {
            final heroTag = widget.heroTags?.elementAt(idx) ?? uuid.v4();
            return PhotoViewGalleryPageOptions(
              imageProvider: UniversalImage.provider(
                sn.getAttachmentUrl(widget.data.elementAt(idx).rid),
              ),
              heroAttributes: PhotoViewHeroAttributes(
                tag: 'attachment-${widget.data.first.rid}-$heroTag',
              ),
            );
          },
          itemCount: widget.data.length,
          loadingBuilder: (context, event) => Center(
            child: SizedBox(
              width: 20.0,
              height: 20.0,
              child: CircularProgressIndicator(
                value: event == null
                    ? 0
                    : event.cumulativeBytesLoaded /
                        (event.expectedTotalBytes ?? 1),
              ),
            ),
          ),
          backgroundDecoration: BoxDecoration(color: Colors.transparent),
        );
      }),
    );
  }
}
