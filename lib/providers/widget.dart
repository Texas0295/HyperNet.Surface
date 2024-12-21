import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'package:surface/providers/sn_network.dart';
import 'package:surface/types/post.dart';

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
      const widgets = ["SolarRandomPostWidget", "SolarCheckInWidget"];
      for (final widget in widgets) {
        await HomeWidget.updateWidget(
          name: widget,
          iOSName: widget,
        );
      }
    } else if (Platform.isAndroid) {
      const widgets = ["RandomPostWidget", "CheckInWidget"];
      for (final widget in widgets) {
        await HomeWidget.updateWidget(
          androidName: "${widget}Receiver",
          qualifiedAndroidName: "dev.solsynth.solian.widgets.${widget}Receiver",
        );
      }
    }
  }
}

Future<void> widgetUpdateRandomPost() async {
  final snc = await SnNetworkProvider.createOffContextClient();
  final resp = await snc.get('/cgi/co/recommendations/shuffle?take=1');
  final post = SnPost.fromJson(resp.data['data'][0]);
  await HomeWidget.saveWidgetData("int_random_post", jsonEncode(post.toJson()));
  await HomeWidget.updateWidget(
    name: "SolarRandomPostWidget",
    iOSName: "SolarRandomPostWidget",
    androidName: "RandomPostWidgetReceiver",
    qualifiedAndroidName: "dev.solsynth.solian.widgets.RandomPostWidgetReceiver",
  );
}
