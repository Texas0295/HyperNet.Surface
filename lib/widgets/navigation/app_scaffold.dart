import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:surface/widgets/dialog.dart';
import 'package:surface/widgets/navigation/app_background.dart';
import 'package:surface/widgets/navigation/app_bottom_navigation.dart';
import 'package:surface/widgets/navigation/app_drawer_navigation.dart';
import 'package:surface/widgets/navigation/app_rail_navigation.dart';

class AppScaffold extends StatelessWidget {
  final String? title;
  final Widget? body;
  final bool showAppBar;
  final bool showBottomNavigation;
  const AppScaffold({
    super.key,
    this.title,
    this.body,
    this.showAppBar = true,
    this.showBottomNavigation = false,
  });

  @override
  Widget build(BuildContext context) {
    final isShowBottomNavigation = (showBottomNavigation)
        ? ResponsiveBreakpoints.of(context).smallerOrEqualTo(MOBILE)
        : false;

    final state = GoRouter.maybeOf(context);
    final autoTitle = state != null
        ? 'screen${state.routerDelegate.currentConfiguration.last.route.name?.capitalize()}'
        : 'screen';

    return Scaffold(
      appBar: showAppBar
          ? AppBar(
              title: Text(title ?? autoTitle.tr()),
            )
          : null,
      body: body,
      bottomNavigationBar:
          isShowBottomNavigation ? AppBottomNavigationBar() : null,
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
      child: Scaffold(
        body: innerWidget,
        drawer: !isExpandDrawer ? AppNavigationDrawer() : null,
      ),
    );
  }
}
