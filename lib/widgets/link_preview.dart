import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:surface/types/link.dart';
import 'package:surface/widgets/universal_image.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../providers/link_preview.dart';

class LinkPreviewWidget extends StatefulWidget {
  final String text;

  const LinkPreviewWidget({super.key, required this.text});

  @override
  State<LinkPreviewWidget> createState() => _LinkPreviewWidgetState();
}

class _LinkPreviewWidgetState extends State<LinkPreviewWidget> {
  final List<SnLinkMeta> _links = List.empty(growable: true);

  Future<void> _getLinkMeta() async {
    final linkRegex = RegExp(r'https?:\/\/[^\s/$.?#].[^\s]*');
    final links = linkRegex.allMatches(widget.text).map((e) => e.group(0)).toSet();

    final lp = context.read<SnLinkPreviewProvider>();

    final List<Future<SnLinkMeta?>> futures = links.where((e) => e != null).map((e) => lp.getLinkMeta(e!)).toList();
    final results = await Future.wait(futures);

    _links.addAll(results.where((e) => e != null).map((e) => e!).toList());
    if (_links.isNotEmpty && mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getLinkMeta();
  }

  @override
  Widget build(BuildContext context) {
    if (_links.isEmpty) return const SizedBox.shrink();

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _links
          .map(
            (e) => Container(
              constraints: BoxConstraints(
                maxWidth: ResponsiveBreakpoints.of(context).smallerOrEqualTo(MOBILE) ? double.infinity : 480,
              ),
              child: GestureDetector(
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (e.image != null)
                        Container(
                          margin: const EdgeInsets.only(bottom: 4),
                          color: Theme.of(context).colorScheme.surfaceContainer,
                          child: AspectRatio(
                            aspectRatio: 16 / 9,
                            child: ClipRRect(
                              child: AutoResizeUniversalImage(
                                e.image!,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      SizedBox(
                        height: 48,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (e.icon != null)
                              UniversalImage(
                                e.icon!,
                                width: 36,
                                height: 36,
                                cacheHeight: 36,
                                cacheWidth: 36,
                              ).padding(all: 4),
                            const Gap(12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 24,
                                    child: Marquee(
                                      text: e.title ?? 'unknown'.tr(),
                                      style: TextStyle(fontSize: 17, height: 1),
                                      scrollAxis: Axis.horizontal,
                                      showFadingOnlyWhenScrolling: true,
                                      pauseAfterRound: const Duration(seconds: 3),
                                    ),
                                  ),
                                  if (e.siteName != null)
                                    Text(
                                      e.siteName!,
                                      style: TextStyle(fontSize: 13, height: 0.9),
                                    ).fontSize(11),
                                ],
                              ),
                            ),
                            const Gap(6),
                          ],
                        ).padding(horizontal: 16),
                      ),
                      Text(
                        e.description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ).padding(horizontal: 16),
                      const Gap(8),
                      Text(
                        e.url,
                        style: GoogleFonts.roboto(fontSize: 11, height: 0.9),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ).opacity(0.75).padding(horizontal: 16),
                      const Gap(4),
                      Text(
                        'poweredBy'.tr(args: ['HyperNet.Reader']),
                        style: GoogleFonts.roboto(fontSize: 11, height: 0.9),
                      ).opacity(0.75).padding(horizontal: 16),
                      const Gap(16),
                    ],
                  ),
                ),
                onTap: () {
                  launchUrlString(e.url, mode: LaunchMode.externalApplication);
                },
              ),
            ),
          )
          .toList(),
    );
  }
}
