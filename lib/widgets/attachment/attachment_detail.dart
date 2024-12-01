import 'package:dismissible_page/dismissible_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:surface/providers/sn_network.dart';
import 'package:surface/providers/user_directory.dart';
import 'package:surface/types/attachment.dart';
import 'package:surface/widgets/account/account_image.dart';
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

  void _updatePage() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_updatePage);
    Future.delayed(const Duration(milliseconds: 100), _updatePage);
  }

  @override
  void dispose() {
    _pageController.removeListener(_updatePage);
    _pageController.dispose();
    super.dispose();
  }

  Color get _unFocusColor =>
      Theme.of(context).colorScheme.onSurface.withOpacity(0.75);

  @override
  Widget build(BuildContext context) {
    final sn = context.read<SnNetworkProvider>();
    final uuid = Uuid();

    final metaTextStyle = GoogleFonts.roboto(
      fontSize: 12,
      color: _unFocusColor,
      height: 1,
    );

    return DismissiblePage(
      onDismissed: () {
        Navigator.of(context).pop();
      },
      direction: DismissiblePageDismissDirection.down,
      backgroundColor: Colors.transparent,
      isFullScreen: true,
      child: Stack(
        children: [
          Builder(builder: (context) {
            if (widget.data.length == 1) {
              final heroTag = widget.heroTags?.first ?? uuid.v4();
              return Hero(
                tag: 'attachment-${widget.data.first.rid}-$heroTag',
                child: PhotoView(
                  key: Key(
                      'attachment-detail-${widget.data.first.rid}-$heroTag'),
                  backgroundDecoration:
                      BoxDecoration(color: Colors.transparent),
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
          Align(
            alignment: Alignment.bottomCenter,
            child: IgnorePointer(
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Theme.of(context).colorScheme.surface,
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).padding.bottom > 16
                ? -MediaQuery.of(context).padding.bottom
                : 16,
            child: SizedBox(
              height: 180,
              child: Material(
                color: Colors.transparent,
                child: Builder(builder: (context) {
                  final ud = context.read<UserDirectoryProvider>();
                  final item = widget.data.elementAt(
                    widget.data.length > 1
                        ? _pageController.page?.round() ?? 0
                        : 0,
                  );
                  final account = ud.getAccountFromCache(item.accountId);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (item.accountId > 0)
                        Row(
                          children: [
                            IgnorePointer(
                              child: AccountImage(
                                content: account!.avatar,
                                radius: 19,
                              ),
                            ),
                            const Gap(8),
                            Expanded(
                              child: IgnorePointer(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'attachmentUploadBy'.tr(),
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    Text(
                                      account.nick,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (widget.data.length > 1)
                              IgnorePointer(
                                child: Text(
                                  '${(_pageController.page?.round() ?? 0) + 1}/${widget.data.length}',
                                  style: GoogleFonts.robotoMono(fontSize: 13),
                                ).padding(right: 8),
                              ),
                          ],
                        ),
                      const Gap(4),
                      IgnorePointer(
                        child: Text(
                          item.alt,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Gap(2),
                      IgnorePointer(
                        child: Wrap(
                          spacing: 6,
                          children: [
                            if (item.metadata['exif'] == null)
                              Text(
                                '#${item.rid}',
                                style: metaTextStyle,
                              ),
                            if (item.metadata['exif']?['Model'] != null)
                              Text(
                                'attachmentShotOn'.tr(args: [
                                  item.metadata['exif']?['Model'],
                                ]),
                                style: metaTextStyle,
                              ).padding(right: 2),
                            if (item.metadata['exif']?['ShutterSpeed'] != null)
                              Text(
                                item.metadata['exif']?['ShutterSpeed'],
                                style: metaTextStyle,
                              ).padding(right: 2),
                            if (item.metadata['exif']?['ISO'] != null)
                              Text(
                                'ISO${item.metadata['exif']?['ISO']}',
                                style: metaTextStyle,
                              ).padding(right: 2),
                            if (item.metadata['exif']?['Aperture'] != null)
                              Text(
                                'f/${item.metadata['exif']?['Aperture']}',
                                style: metaTextStyle,
                              ).padding(right: 2),
                            if (item.metadata['exif']?['Megapixels'] != null &&
                                item.metadata['exif']?['Model'] != null)
                              Text(
                                '${item.metadata['exif']?['Megapixels']}MP',
                                style: metaTextStyle,
                              )
                            else
                              Text(
                                '${item.size} Bytes',
                                style: metaTextStyle,
                              ),
                            Text(
                              '${item.metadata['width']}x${item.metadata['height']}',
                              style: metaTextStyle,
                            ),
                            if (item.metadata['ratio'] != null)
                              Text(
                                (item.metadata['ratio'] as num)
                                    .toStringAsFixed(2),
                                style: metaTextStyle,
                              ),
                            Text(
                              item.mimetype,
                              style: metaTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
