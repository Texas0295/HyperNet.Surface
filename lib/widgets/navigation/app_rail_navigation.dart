import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:surface/providers/navigation.dart';

class AppRailNavigation extends StatefulWidget {
  const AppRailNavigation({super.key});

  @override
  State<AppRailNavigation> createState() => _AppRailNavigationState();
}

class _AppRailNavigationState extends State<AppRailNavigation> {
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

    return ListenableBuilder(
      listenable: nav,
      builder: (context, _) {
        final destinations = nav.destinations.where((ele) => ele.isPinned).toList();

        return NavigationRail(
          selectedIndex:
              nav.currentIndex != null && nav.currentIndex! < nav.pinnedDestinationCount ? nav.currentIndex : null,
          destinations: [
            ...destinations.where((ele) => ele.isPinned).map((ele) {
              return NavigationRailDestination(
                icon: ele.icon,
                label: Text(ele.label).tr(),
              );
            }),
          ],
          trailing: Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: StyledWidget(
                IconButton(
                  icon: const Icon(Symbols.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ).padding(bottom: 16),
            ),
          ),
          onDestinationSelected: (idx) {
            nav.setIndex(idx);
            GoRouter.of(context).goNamed(destinations[idx].screen);
          },
        );
      },
    );
  }
}
