import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_context_menu/flutter_context_menu.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ContextMenuArea extends StatelessWidget {
  final ContextMenu contextMenu;
  final Widget child;
  final ValueChanged<dynamic>? onItemSelected;

  const ContextMenuArea({
    super.key,
    required this.contextMenu,
    required this.child,
    this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    Offset mousePosition = Offset.zero;

    return Listener(
      onPointerDown: (event) {
        mousePosition = event.position;
        final isCollapseDrawer = ResponsiveBreakpoints.of(context).smallerOrEqualTo(MOBILE);
        if (!isCollapseDrawer) {
          final isExpandDrawer = ResponsiveBreakpoints.of(context).largerThan(TABLET);
          // Leave padding for side navigation
          mousePosition = isExpandDrawer
              ? mousePosition.copyWith(dx: mousePosition.dx - 304 * 2)
              : mousePosition.copyWith(dx: mousePosition.dx - 72 * 2);
        }
      },
      child: GestureDetector(
        onLongPress: () => _showMenu(context, mousePosition),
        onSecondaryTap: () => _showMenu(context, mousePosition),
        child: child,
      ),
    );
  }

  void _showMenu(BuildContext context, Offset mousePosition) async {
    final menu = contextMenu.copyWith(position: contextMenu.position ?? mousePosition);
    final value = await showContextMenu(context, contextMenu: menu);
    onItemSelected?.call(value);
  }
}
