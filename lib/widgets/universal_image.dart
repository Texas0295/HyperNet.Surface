import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:flutter_animate/flutter_animate.dart';

class UniversalImage extends StatelessWidget {
  final String url;
  final double? width, height;
  final BoxFit? fit;
  final bool noProgressIndicator;
  final bool noErrorWidget;
  final double? cacheWidth, cacheHeight;

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
  });

  @override
  Widget build(BuildContext context) {
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;

    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS || Platform.isMacOS)) {
      return CachedNetworkImage(
        imageUrl: url,
        width: width,
        height: height,
        fit: fit,
        memCacheHeight: cacheHeight != null
            ? (cacheHeight! * devicePixelRatio).round()
            : null,
        memCacheWidth: cacheWidth != null
            ? (cacheWidth! * devicePixelRatio).round()
            : null,
        progressIndicatorBuilder: noProgressIndicator
            ? null
            : (context, url, downloadProgress) => Center(
                  child: TweenAnimationBuilder(
                    tween: Tween(
                      begin: 0,
                      end: downloadProgress.progress ?? 0,
                    ),
                    duration: const Duration(milliseconds: 300),
                    builder: (context, value, _) => CircularProgressIndicator(
                      value: downloadProgress.progress != null
                          ? value.toDouble()
                          : null,
                    ),
                  ),
                ),
        errorWidget: noErrorWidget
            ? null
            : (context, url, error) {
                return Container(
                  color: Theme.of(context).colorScheme.surface,
                  constraints: const BoxConstraints(maxWidth: 280),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimateWidgetExtensions(Icon(Icons.close, size: 24))
                          .animate(onPlay: (e) => e.repeat(reverse: true))
                          .fade(duration: 500.ms),
                      Text(
                        error.toString(),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ).center(),
                );
              },
      );
    }
    return Image.network(
      url,
      width: width,
      height: height,
      fit: fit,
      cacheHeight: cacheHeight != null
          ? (cacheHeight! * devicePixelRatio).round()
          : null,
      cacheWidth:
          cacheWidth != null ? (cacheWidth! * devicePixelRatio).round() : null,
      loadingBuilder: noProgressIndicator
          ? null
          : (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: TweenAnimationBuilder(
                  tween: Tween(
                    begin: 0,
                    end: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : 0,
                  ),
                  duration: const Duration(milliseconds: 300),
                  builder: (context, value, _) => CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? value.toDouble()
                        : null,
                  ),
                ),
              );
            },
      errorBuilder: noErrorWidget
          ? null
          : (context, error, stackTrace) {
              return Material(
                color: Theme.of(context).colorScheme.surface,
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 280),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimateWidgetExtensions(Icon(Icons.close, size: 24))
                          .animate(onPlay: (e) => e.repeat(reverse: true))
                          .fade(duration: 500.ms),
                      Text(
                        error.toString(),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ).center(),
                ),
              );
            },
    );
  }

  static ImageProvider provider(String url) {
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS || Platform.isMacOS)) {
      return CachedNetworkImageProvider(url);
    }
    return NetworkImage(url);
  }
}
