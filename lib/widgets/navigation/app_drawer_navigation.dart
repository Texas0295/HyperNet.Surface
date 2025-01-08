import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:surface/providers/config.dart';
import 'package:surface/providers/navigation.dart';
import 'package:surface/widgets/version_label.dart';

class AppNavigationDrawer extends StatefulWidget {
  final double? elevation;

  const AppNavigationDrawer({super.key, this.elevation});

  @override
  State<AppNavigationDrawer> createState() => _AppNavigationDrawerState();
}

class _AppNavigationDrawerState extends State<AppNavigationDrawer> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NavigationProvider>().autoDetectIndex(GoRouter.maybeOf(context));
    });
  }

  @override
  Widget build(BuildContext context) {
    final nav = context.watch<NavigationProvider>();
    final cfg = context.watch<ConfigProvider>();

    final backgroundColor = cfg.drawerIsExpanded ? Colors.transparent : null;

    return ListenableBuilder(
      listenable: nav,
      builder: (context, _) {
        final destinations = [
          ...nav.destinations.where((ele) => ele.isPinned),
          ...nav.destinations.where((ele) => !ele.isPinned),
        ];

        return NavigationDrawer(
          elevation: widget.elevation,
          backgroundColor: backgroundColor,
          selectedIndex: nav.currentIndex,
          children: [
            if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS) && !cfg.drawerIsExpanded)
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Theme.of(context).dividerColor,
                      width: 1 / MediaQuery.of(context).devicePixelRatio,
                    ),
                  ),
                ),
                child: WindowTitleBarBox(),
              ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Solar Network').bold(),
                AppVersionLabel(),
              ],
            ).padding(
              horizontal: 32,
              vertical: 12,
            ),
            ...destinations.where((ele) => ele.isPinned).map((ele) {
              return NavigationDrawerDestination(
                icon: ele.icon,
                label: Text(ele.label).tr(),
              );
            }),
            const Divider(),
            ...destinations.where((ele) => !ele.isPinned).map((ele) {
              return NavigationDrawerDestination(
                icon: ele.icon,
                label: Text(ele.label).tr(),
              );
            }),
          ],
          onDestinationSelected: (idx) {
            nav.setIndex(idx);
            GoRouter.of(context).goNamed(destinations[idx].screen);
            Scaffold.of(context).closeDrawer();
          },
        );
      },
    );
  }
}
