import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:flutter_animate/flutter_animate.dart';

// Keep this import to make the web image render work
import 'package:surface/providers/config.dart';

class UniversalImage extends StatelessWidget {
  final String url;
  final double? width, height;
  final BoxFit? fit;
  final bool noProgressIndicator;
  final bool noErrorWidget;
  final double? cacheWidth, cacheHeight;
  final FilterQuality? filterQuality;

  const UniversalImage(
    this.url, {
    super.key,
    this.width,
    this.height,
    this.fit,
    this.noProgressIndicator = false,
    this.noErrorWidget = false,
    this.cacheWidth,
    this.cacheHeight,
    this.filterQuality,
  });

  @override
  Widget build(BuildContext context) {
    final quality = filterQuality ?? context.read<ConfigProvider>().imageQuality;

    return ExtendedImage.network(
      url,
      width: width,
      height: height,
      fit: fit,
      cache: true,
      compressionRatio: kIsWeb ? 1 : switch(quality) {
        FilterQuality.high => 1,
        FilterQuality.medium => 0.75,
        FilterQuality.low => 0.5,
        FilterQuality.none => 0.25,
      },
      filterQuality: quality,
      enableLoadState: true,
      retries: 3,
      loadStateChanged: (ExtendedImageState state) {
        if (state.extendedImageLoadState == LoadState.completed) {
          return state.completedWidget;
        } else if (state.extendedImageLoadState == LoadState.failed) {
          return Material(
            color: Theme.of(context).colorScheme.surface,
            child: Container(
              constraints: const BoxConstraints(maxWidth: 280),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimateWidgetExtensions(Icon(Symbols.close, size: 24))
                      .animate(onPlay: (e) => e.repeat(reverse: true))
                      .fade(duration: 500.ms),
                  Text(
                    state.lastException.toString(),
                    textAlign: TextAlign.center,
                  ),
                ],
              ).center(),
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(
            value: state.loadingProgress != null
                ? state.loadingProgress!.cumulativeBytesLoaded / state.loadingProgress!.expectedTotalBytes!
                : null,
          ),
        );
      },
    );
  }

  static ImageProvider provider(String url) {
    // This place used to use network image or cached network image depending on the platform.
    // But now the cached network image is working on every platform.
    // So we just use it now.
    return ExtendedNetworkImageProvider(
      url,
      cache: true,
      retries: 3,
    );
  }
}

class AutoResizeUniversalImage extends StatelessWidget {
  final String url;
  final double? width, height;
  final BoxFit? fit;
  final bool noProgressIndicator;
  final bool noErrorWidget;

  const AutoResizeUniversalImage(
    this.url, {
    super.key,
    this.width,
    this.height,
    this.fit,
    this.noProgressIndicator = false,
    this.noErrorWidget = false,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return UniversalImage(
        url,
        fit: fit,
        width: width,
        height: height,
        noProgressIndicator: noProgressIndicator,
        noErrorWidget: noErrorWidget,
        cacheHeight: constraints.maxHeight,
        cacheWidth: constraints.maxWidth,
      );
    });
  }
}
