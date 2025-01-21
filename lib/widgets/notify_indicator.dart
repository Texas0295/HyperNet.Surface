import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:surface/providers/notification.dart';
import 'package:surface/providers/userinfo.dart';

class NotifyIndicator extends StatelessWidget {
  const NotifyIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final ua = context.read<UserProvider>();
    final nty = context.watch<NotificationProvider>();

    final show = nty.notifications.isNotEmpty && ua.isAuthorized;

    return ListenableBuilder(
        listenable: nty,
        builder: (context, _) {
          return IgnorePointer(
            ignoring: !show,
            child: GestureDetector(
              child: Material(
                elevation: 2,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
                color: Theme.of(context).colorScheme.secondaryContainer,
                child: ua.isAuthorized
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            nty.notifications.lastOrNull?.title ??
                                'notificationUnreadCount'.plural(nty.notifications.length),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (nty.notifications.lastOrNull?.body != null)
                            Text(
                              nty.notifications.lastOrNull!.body,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ).padding(left: 4),
                          const Gap(8),
                          const Icon(Symbols.notifications_unread, size: 18),
                        ],
                      ).padding(horizontal: 8, vertical: 4)
                    : const SizedBox.shrink(),
              ).opacity(show ? 1 : 0, animate: true).animate(
                    const Duration(milliseconds: 300),
                    Curves.easeInOut,
                  ),
              onTap: () {
                nty.clear();
              },
            ),
          );
        });
  }
}
