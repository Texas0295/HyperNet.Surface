import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import 'package:surface/providers/channel.dart';
import 'package:surface/providers/user_directory.dart';
import 'package:surface/types/chat.dart';
import 'package:surface/widgets/account/account_image.dart';
import 'package:surface/widgets/dialog.dart';
import 'package:surface/widgets/loading_indicator.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isBusy = true;

  List<SnChannel>? _channels;
  Map<int, SnChatMessage>? _lastMessages;

  void _refreshChannels() {
    final chan = context.read<ChatChannelProvider>();
    chan.fetchChannels().listen((channels) async {
      final lastMessages = await chan.getLastMessages(channels);
      _lastMessages = {for (final val in lastMessages) val.channelId: val};
      channels.sort((a, b) {
        if (_lastMessages!.containsKey(a.id) &&
            _lastMessages!.containsKey(b.id)) {
          return _lastMessages![b.id]!
              .createdAt
              .compareTo(_lastMessages![a.id]!.createdAt);
        }
        if (_lastMessages!.containsKey(a.id)) return -1;
        if (_lastMessages!.containsKey(b.id)) return 1;
        return 0;
      });

      if (mounted) setState(() => _channels = channels);
    })
      ..onError((err) {
        if (!mounted) return;
        context.showErrorDialog(err);
        setState(() => _isBusy = false);
      })
      ..onDone(() {
        if (!mounted) return;
        setState(() => _isBusy = false);
      });
  }

  @override
  void initState() {
    super.initState();
    _refreshChannels();
  }

  @override
  Widget build(BuildContext context) {
    final ud = context.read<UserDirectoryProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text('screenChat').tr(),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Symbols.chat_add_on),
        onPressed: () {
          GoRouter.of(context).pushNamed('chatManage').then((value) {
            if (value != null && context.mounted) _refreshChannels();
          });
        },
      ),
      body: Column(
        children: [
          LoadingIndicator(isActive: _isBusy),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => Future.sync(() => _refreshChannels()),
              child: ListView.builder(
                itemCount: _channels?.length ?? 0,
                itemBuilder: (context, idx) {
                  final channel = _channels![idx];
                  final lastMessage = _lastMessages?[channel.id];
                  return ListTile(
                    title: Text(channel.name),
                    subtitle: lastMessage != null
                        ? Text(
                            '${ud.getAccountFromCache(lastMessage.sender.accountId)?.nick}: ${lastMessage.body['text'] ?? 'Unable preview'}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )
                        : Text(
                            channel.description,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    leading: AccountImage(
                      content: null,
                      fallbackWidget: const Icon(Symbols.chat, size: 20),
                    ),
                    onTap: () {
                      GoRouter.of(context).pushNamed(
                        'chatRoom',
                        pathParameters: {
                          'scope': channel.realm?.alias ?? 'global',
                          'alias': channel.alias,
                        },
                      ).then((value) {
                        if (value == true) _refreshChannels();
                      });
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
