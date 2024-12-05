import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:surface/widgets/navigation/app_scaffold.dart';

class AutoAppBarLeading extends StatelessWidget {
  const AutoAppBarLeading({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBreakpoints.of(context).smallerOrEqualTo(MOBILE)
        ? DrawerButton(onPressed: () {
            globalRootScaffoldKey.currentState?.openDrawer();
          })
        : Navigator.canPop(context)
            ? BackButton()
            : const SizedBox();
  }
}
