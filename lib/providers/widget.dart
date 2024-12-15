import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';

class HomeWidgetProvider {
  HomeWidgetProvider(BuildContext context);

  Future<void> initialize() async {
    if (kIsWeb || !(Platform.isAndroid || Platform.isIOS)) return;
    if (!kIsWeb && Platform.isIOS) {
      await HomeWidget.setAppGroupId("group.solsynth.solian");
    }
  }

  Future<void> saveWidgetData(String id, dynamic data, {bool update = true}) async {
    if (kIsWeb || !(Platform.isAndroid || Platform.isIOS)) return;
    await HomeWidget.saveWidgetData(id, jsonEncode(data));
    if (update) await updateWidget();
  }

  Future<void> updateWidget() async {
    if (kIsWeb || !(Platform.isAndroid || Platform.isIOS)) return;
    if (Platform.isIOS) {
      const widgets = ["SolarFeaturedPostWidget", "SolarCheckInWidget"];
      for (final widget in widgets) {
        await HomeWidget.updateWidget(
          name: widget,
          iOSName: widget,
          androidName: "com.solsynth.solian.$widget",
          qualifiedAndroidName: "group.solsynth.solian.$widget",
        );
      }
    }
  }
}
