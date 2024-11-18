import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_context_menu/flutter_context_menu.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:surface/providers/user_directory.dart';
import 'package:surface/providers/userinfo.dart';
import 'package:surface/types/chat.dart';
import 'package:surface/widgets/account/account_image.dart';
import 'package:surface/widgets/attachment/attachment_list.dart';
import 'package:surface/widgets/markdown_content.dart';
import 'package:swipe_to/swipe_to.dart';

class ChatMessage extends StatelessWidget {
  final SnChatMessage data;
  final bool isCompact;
  final bool isMerged;
  final bool hasMerged;
  final bool isPending;
  final Function(SnChatMessage)? onReply;
  final Function(SnChatMessage)? onEdit;
  final Function(SnChatMessage)? onDelete;
  const ChatMessage({
    super.key,
    required this.data,
    this.isCompact = false,
    this.isMerged = false,
    this.hasMerged = false,
    this.isPending = false,
    this.onReply,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final ua = context.read<UserProvider>();
    final ud = context.read<UserDirectoryProvider>();
    final user = ud.getAccountFromCache(data.sender.accountId);

    final isOwner = ua.isAuthorized && data.sender.accountId == ua.user!.id;

    final dateFormatter = DateFormat('MM/dd HH:mm');

    return SwipeTo(
      key: Key('chat-message-${data.id}'),
      iconOnLeftSwipe: Symbols.reply,
      swipeSensitivity: 20,
      onLeftSwipe: onReply != null ? (_) => onReply!(data) : null,
      child: ContextMenuRegion(
        contextMenu: ContextMenu(
          entries: [
            MenuHeader(text: "eventResourceTag".tr(args: ['#${data.id}'])),
            if (onReply != null)
              MenuItem(
                label: 'reply'.tr(),
                icon: Symbols.reply,
                onSelected: () {
                  onReply!(data);
                },
              ),
            if (isOwner && onEdit != null)
              MenuItem(
                label: 'edit'.tr(),
                icon: Symbols.edit,
                onSelected: () {
                  onEdit!(data);
                },
              ),
            if (isOwner && onDelete != null)
              MenuItem(
                label: 'delete'.tr(),
                icon: Symbols.delete,
                onSelected: () {
                  onDelete!(data);
                },
              ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isMerged && !isCompact)
                  AccountImage(
                    content: user?.avatar,
                  )
                else if (isMerged)
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
                            if (isCompact)
                              AccountImage(
                                content: user?.avatar,
                                radius: 12,
                              ).padding(right: 6),
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
                      if (isCompact) const Gap(4),
                      if (data.preload?.quoteEvent != null)
                        StyledWidget(Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            border: Border.all(
                              color: Theme.of(context).dividerColor,
                              width: 1,
                            ),
                          ),
                          padding: const EdgeInsets.only(
                            left: 4,
                            right: 4,
                            top: 8,
                            bottom: 6,
                          ),
                          child: ChatMessage(
                            data: data.preload!.quoteEvent!,
                            isCompact: true,
                            onReply: onReply,
                            onEdit: onEdit,
                            onDelete: onDelete,
                          ),
                        )).padding(bottom: 4, top: isMerged ? 4 : 2),
                      if (data.body['text'] != null)
                        MarkdownTextContent(
                          content: data.body['text'],
                          isAutoWarp: true,
                        ),
                    ],
                  ),
                )
              ],
            ).opacity(isPending ? 0.5 : 1),
            if (data.preload?.attachments?.isNotEmpty ?? false)
              AttachmentList(
                data: data.preload!.attachments!,
                bordered: true,
                noGrow: true,
                maxHeight: 520,
                listPadding: const EdgeInsets.only(top: 8),
              ),
            if (!hasMerged && !isCompact) const Gap(12),
          ],
        ),
      ),
    );
  }
}
