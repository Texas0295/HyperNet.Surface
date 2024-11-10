import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class AppBackground extends StatelessWidget {
  final Widget child;
  const AppBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;

    return ScaffoldMessenger(
      child: FutureBuilder(
        future:
            kIsWeb ? Future.value(null) : getApplicationDocumentsDirectory(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final path = '${snapshot.data!.path}/app_background_image';
            final file = File(path);
            if (file.existsSync()) {
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
                            FileImage(file),
                            width: (constraints.maxWidth * devicePixelRatio)
                                .round(),
                            height: (constraints.maxHeight * devicePixelRatio)
                                .round(),
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
