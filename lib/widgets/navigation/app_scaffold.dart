import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:surface/widgets/dialog.dart';
import 'package:surface/widgets/navigation/app_background.dart';
import 'package:surface/widgets/navigation/app_bottom_navigation.dart';

class AppScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final String? title;
  final Widget? body;
  final bool autoImplyAppBar;
  final bool showBottomNavigation;
  const AppScaffold({
    super.key,
    this.appBar,
    this.title,
    this.body,
    this.autoImplyAppBar = false,
    this.showBottomNavigation = false,
  });

  @override
  Widget build(BuildContext context) {
    final isShowBottomNavigation = (showBottomNavigation)
        ? ResponsiveBreakpoints.of(context).smallerOrEqualTo(MOBILE)
        : false;

    final state = GoRouter.maybeOf(context);

    return AppBackground(
      child: Scaffold(
        appBar: appBar ??
            (autoImplyAppBar
                ? AppBar(
                    title: title != null
                        ? Text(title!)
                        : state != null
                            ? Text(
                                ('screen${state.routerDelegate.currentConfiguration.last.route.name?.capitalize()}')
                                    .tr(),
                              )
                            : null)
                : null),
        body: body,
        bottomNavigationBar:
            isShowBottomNavigation ? AppBottomNavigationBar() : null,
      ),
    );
  }
}
