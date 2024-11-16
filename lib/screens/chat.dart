import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import 'package:surface/providers/channel.dart';
import 'package:surface/types/chat.dart';
import 'package:surface/widgets/account/account_image.dart';
import 'package:surface/widgets/loading_indicator.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isBusy = true;

  List<SnChannel>? _channels;

  @override
  void initState() {
    super.initState();
    final chan = context.read<ChatChannelProvider>();
    chan.fetchChannels().listen((channels) {
      if (mounted) setState(() => _channels = channels);
    })
      ..onError((_) {
        setState(() => _isBusy = false);
      })
      ..onDone(() {
        setState(() => _isBusy = false);
      });
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
      body: Column(
        children: [
          LoadingIndicator(isActive: _isBusy),
          Expanded(
            child: ListView.builder(
              itemCount: _channels?.length ?? 0,
              itemBuilder: (context, idx) {
                final channel = _channels![idx];
                return ListTile(
                  title: Text(channel.name),
                  subtitle: Text(
                    channel.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  leading: AccountImage(
                    content: null,
                    fallbackWidget: const Icon(Symbols.chat, size: 20),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
