import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import 'package:surface/providers/sn_network.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Future<void> _fetchChannels({scope = 'global', direct = false}) async {
    final sn = context.read<SnNetworkProvider>();
    final resp = await sn.client.get(
      '/cgi/im/channels/$scope/me/available',
      queryParameters: {
        'direct': direct,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('screenChat').tr(),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Symbols.chat_add_on),
        onPressed: () {
          GoRouter.of(context).pushNamed('chatManage');
        },
      ),
    );
  }
}
