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

  Future<void> saveWidgetData(String id, dynamic data) async {
    if (kIsWeb || !(Platform.isAndroid || Platform.isIOS)) return;
    await HomeWidget.saveWidgetData(id, jsonEncode(data));
  }

  Future<void> updateWidget() async {
    if (kIsWeb || !(Platform.isAndroid || Platform.isIOS)) return;
    await HomeWidget.updateWidget(
      name: "SolarWidget",
      iOSName: "SolarWidget",
      androidName: "com.solsynth.solian.SolarWidget",
      qualifiedAndroidName: "group.solsynth.solian.SolarWidget",
    );
  }
}
