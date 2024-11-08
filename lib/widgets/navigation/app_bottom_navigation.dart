import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:surface/widgets/navigation/app_destinations.dart';

class AppBottomNavigationBar extends StatefulWidget {
  const AppBottomNavigationBar({super.key});

  @override
  State<AppBottomNavigationBar> createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: false,
      items: appDestinations.map((ele) {
        return BottomNavigationBarItem(
          icon: ele.icon,
          label: ele.label,
        );
      }).toList(),
      onTap: (idx) {
        setState(() => _currentIndex = idx);
        GoRouter.of(context).goNamed(appDestinations[idx].screen);
      },
    );
  }
}
