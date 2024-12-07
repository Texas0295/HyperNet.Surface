import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:surface/providers/navigation.dart';
import 'package:surface/widgets/connection_indicator.dart';
import 'package:surface/widgets/dialog.dart';
import 'package:surface/widgets/navigation/app_background.dart';
import 'package:surface/widgets/navigation/app_bottom_navigation.dart';
import 'package:surface/widgets/navigation/app_drawer_navigation.dart';
import 'package:surface/widgets/navigation/app_rail_navigation.dart';

final globalRootScaffoldKey = GlobalKey<ScaffoldState>();

class AppPageScaffold extends StatelessWidget {
  final String? title;
  final Widget? body;
  final bool showAppBar;
  final bool showBottomNavigation;
  const AppPageScaffold({
    super.key,
    this.title,
    this.body,
    this.showAppBar = true,
    this.showBottomNavigation = false,
  });

  @override
  Widget build(BuildContext context) {
    final state = GoRouter.maybeOf(context);
    final routeName =
        state?.routerDelegate.currentConfiguration.last.route.name;

    final autoTitle =
        state != null ? 'screen${routeName?.capitalize()}' : 'screen';

    return Scaffold(
      appBar: showAppBar
          ? AppBar(
              title: Text(title ?? autoTitle.tr()),
            )
          : null,
      body: body,
    );
  }
}

class AppRootScaffold extends StatelessWidget {
  final Widget body;
  const AppRootScaffold({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;

    final isCollapseDrawer =
        ResponsiveBreakpoints.of(context).smallerOrEqualTo(MOBILE);
    final isExpandDrawer = ResponsiveBreakpoints.of(context).largerThan(TABLET);

    final routeName = GoRouter.of(context)
        .routerDelegate
        .currentConfiguration
        .last
        .route
        .name;
    final isShowBottomNavigation =
        NavigationProvider.kShowBottomNavScreen.contains(routeName)
            ? ResponsiveBreakpoints.of(context).smallerOrEqualTo(MOBILE)
            : false;
    final isPopable = !NavigationProvider.kAllDestination
        .map((ele) => ele.screen)
        .contains(routeName);

    final innerWidget = isCollapseDrawer
        ? body
        : Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: Theme.of(context).dividerColor,
                      width: 1 / devicePixelRatio,
                    ),
                  ),
                ),
                child: isExpandDrawer
                    ? AppNavigationDrawer(elevation: 0)
                    : AppRailNavigation(),
              ),
              Expanded(child: body),
            ],
          );

    return AppBackground(
      isRoot: true,
      child: Scaffold(
        key: globalRootScaffoldKey,
        body: Column(
          children: [
            if (!kIsWeb &&
                (Platform.isWindows || Platform.isLinux || Platform.isMacOS))
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Theme.of(context).dividerColor,
                      width: 1 / devicePixelRatio,
                    ),
                  ),
                ),
                child: WindowTitleBarBox(child: MoveWindow()),
              ),
            ConnectionIndicator(),
            Expanded(child: innerWidget),
          ],
        ),
        drawer: !isExpandDrawer ? AppNavigationDrawer() : null,
        drawerEdgeDragWidth: isPopable ? 0 : null,
        bottomNavigationBar:
            isShowBottomNavigation ? AppBottomNavigationBar() : null,
      ),
    );
  }
}
