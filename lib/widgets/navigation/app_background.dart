import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class AppBackground extends StatelessWidget {
  final Widget child;
  final bool isLessOptimization;
  const AppBackground({
    super.key,
    required this.child,
    this.isLessOptimization = false,
  });

  Widget _buildWithBackgroundImage(
    BuildContext context,
    File imageFile,
    Widget child,
  ) {
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;

    if (isLessOptimization) {
      final size = MediaQuery.of(context).size;
      return Container(
        color: Theme.of(context).colorScheme.surface,
        child: Container(
          decoration: BoxDecoration(
            backgroundBlendMode: BlendMode.darken,
            color: Theme.of(context).colorScheme.surface,
            image: DecorationImage(
              opacity: 0.2,
              image: ResizeImage(
                FileImage(imageFile),
                width: (size.width * devicePixelRatio).round(),
                height: (size.height * devicePixelRatio).round(),
                policy: ResizeImagePolicy.fit,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: child,
        ),
      );
    }

    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            decoration: BoxDecoration(
              backgroundBlendMode: BlendMode.darken,
              color: Theme.of(context).colorScheme.surface,
              image: DecorationImage(
                opacity: 0.2,
                image: ResizeImage(
                  FileImage(imageFile),
                  width: (constraints.maxWidth * devicePixelRatio).round(),
                  height: (constraints.maxHeight * devicePixelRatio).round(),
                  policy: ResizeImagePolicy.fit,
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: FutureBuilder(
        future:
            kIsWeb ? Future.value(null) : getApplicationDocumentsDirectory(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final path = '${snapshot.data!.path}/app_background_image';
            final file = File(path);
            if (file.existsSync()) {
              return _buildWithBackgroundImage(context, file, child);
            }
          }

          return Material(
            color: Theme.of(context).colorScheme.surface,
            child: child,
          );
        },
      ),
    );
  }
}
