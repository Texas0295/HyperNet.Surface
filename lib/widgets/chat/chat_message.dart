import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:surface/providers/user_directory.dart';
import 'package:surface/types/chat.dart';
import 'package:surface/widgets/account/account_image.dart';
import 'package:surface/widgets/attachment/attachment_list.dart';
import 'package:surface/widgets/markdown_content.dart';

class ChatMessage extends StatelessWidget {
  final SnChatMessage data;
  final bool isMerged;
  final bool hasMerged;
  final bool isPending;
  const ChatMessage({
    super.key,
    required this.data,
    this.isMerged = false,
    this.hasMerged = false,
    this.isPending = false,
  });

  @override
  Widget build(BuildContext context) {
    final ud = context.read<UserDirectoryProvider>();
    final user = ud.getAccountFromCache(data.sender.accountId);

    final dateFormatter = DateFormat('MM/dd HH:mm');

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isMerged)
          AccountImage(
            content: user?.avatar,
          )
        else
          const Gap(40),
        const Gap(8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isMerged)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      (data.sender.nick?.isNotEmpty ?? false)
                          ? data.sender.nick!
                          : user!.nick,
                    ).bold(),
                    const Gap(6),
                    Text(
                      dateFormatter.format(data.createdAt.toLocal()),
                    ).fontSize(13),
                  ],
                ),
              if (data.body['text'] != null)
                MarkdownTextContent(
                  content: data.body['text'],
                  isAutoWarp: true,
                ),
              if (data.preload?.attachments?.isNotEmpty ?? false)
                AttachmentList(
                  data: data.preload!.attachments!,
                  bordered: true,
                  maxHeight: 520,
                  listPadding: const EdgeInsets.symmetric(horizontal: 12),
                ),
              if (!hasMerged) const Gap(8),
            ],
          ),
        )
      ],
    ).opacity(isPending ? 0.5 : 1);
  }
}
