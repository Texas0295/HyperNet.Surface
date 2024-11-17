import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:surface/providers/user_directory.dart';
import 'package:surface/types/chat.dart';
import 'package:surface/widgets/account/account_image.dart';
import 'package:surface/widgets/markdown_content.dart';

class ChatMessage extends StatelessWidget {
  final SnChatMessage data;
  final bool isPending;
  const ChatMessage({super.key, required this.data, this.isPending = false});

  @override
  Widget build(BuildContext context) {
    final ud = context.read<UserDirectoryProvider>();
    final user = ud.getAccountFromCache(data.sender.accountId);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AccountImage(
          content: user?.avatar,
        ),
        const Gap(8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                (data.sender.nick?.isNotEmpty ?? false)
                    ? data.sender.nick!
                    : user!.nick,
              ).bold(),
              if (data.body['text'] != null)
                MarkdownTextContent(content: data.body['text']),
            ],
          ),
        )
      ],
    ).opacity(isPending ? 0.5 : 1);
  }
}
