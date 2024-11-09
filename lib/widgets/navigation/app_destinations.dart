import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class AppNavDestination {
  final String label;
  final String screen;
  final Widget icon;

  AppNavDestination({
    required this.label,
    required this.screen,
    required this.icon,
  });
}

List<AppNavDestination> appDestinations = [
  AppNavDestination(
    icon: Icon(Symbols.home, weight: 400, opticalSize: 20),
    screen: 'home',
    label: tr('screenHome'),
  ),
  AppNavDestination(
    icon: Icon(Symbols.explore, weight: 400, opticalSize: 20),
    screen: 'explore',
    label: tr('screenExplore'),
  ),
  AppNavDestination(
    icon: Icon(Symbols.account_circle, weight: 400, opticalSize: 20),
    screen: 'account',
    label: tr('screenAccount'),
  ),
];
