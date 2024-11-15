import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:surface/providers/userinfo.dart';
import 'package:surface/providers/websocket.dart';

class ConnectionIndicator extends StatelessWidget {
  const ConnectionIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final ws = context.watch<WebSocketProvider>();

    return ListenableBuilder(
      listenable: ws,
      builder: (context, _) {
        final ua = context.read<UserProvider>();

        return Container(
          padding: EdgeInsets.only(
            bottom: 8,
            top: MediaQuery.of(context).padding.top + 8,
            left: 24,
            right: 24,
          ),
          color: Theme.of(context).colorScheme.secondaryContainer,
          child: ua.isAuthorized
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (ws.isBusy)
                      Text('serverConnecting').tr().textColor(
                          Theme.of(context).colorScheme.onSecondaryContainer)
                    else if (!ws.isConnected)
                      Text('serverDisconnected').tr().textColor(
                          Theme.of(context).colorScheme.onSecondaryContainer),
                  ],
                )
              : const SizedBox.shrink(),
        )
            .height(
                (ws.isBusy || !ws.isConnected) && ua.isAuthorized
                    ? MediaQuery.of(context).padding.top + 36
                    : 0,
                animate: true)
            .animate(
              const Duration(milliseconds: 300),
              Curves.easeInOut,
            );
      },
    );
  }
}
