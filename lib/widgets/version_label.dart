import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:styled_widget/styled_widget.dart';

class AppVersionLabel extends StatelessWidget {
  final double fontSize;
  const AppVersionLabel({super.key, this.fontSize = 12});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: PackageInfo.fromPlatform().then((value) => 'Stable ${value.version}+${value.buildNumber}'),
      builder: (context, snapshot) {
        return Text(!snapshot.hasData ? 'Stable 2.0' : snapshot.data!).fontSize(fontSize).textColor(
              Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            );
      },
    );
  }
}
