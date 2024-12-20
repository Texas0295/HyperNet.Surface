import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

const Map<String, FilterQuality> kImageQualityLevel = {
  'settingsImageQualityLowest': FilterQuality.none,
  'settingsImageQualityLow': FilterQuality.low,
  'settingsImageQualityMedium': FilterQuality.medium,
  'settingsImageQualityHigh': FilterQuality.high,
};

class ConfigProvider {
  late final SharedPreferences prefs;

  Future<void> initialize() async {
    prefs = await SharedPreferences.getInstance();
  }

  FilterQuality get imageQuality {
    return kImageQualityLevel.values.elementAtOrNull(prefs.getInt('app_image_quality') ?? 3) ?? FilterQuality.high;
  }
}
