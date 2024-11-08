import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:surface/widgets/navigation/app_background.dart';
import 'package:surface/widgets/navigation/app_bottom_navigation.dart';

class AppScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final bool? showBottomNavigation;
  const AppScaffold(
      {super.key, this.appBar, this.body, this.showBottomNavigation});

  @override
  Widget build(BuildContext context) {
    final isShowBottomNavigation = (showBottomNavigation ?? false)
        ? ResponsiveBreakpoints.of(context).smallerOrEqualTo(MOBILE)
        : false;

    return AppBackground(
      child: Scaffold(
        appBar: appBar,
        body: body,
        bottomNavigationBar:
            isShowBottomNavigation ? AppBottomNavigationBar() : null,
      ),
    );
  }
}
