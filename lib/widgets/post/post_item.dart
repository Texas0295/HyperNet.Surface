import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import 'package:relative_time/relative_time.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:surface/providers/userinfo.dart';
import 'package:surface/types/post.dart';
import 'package:surface/widgets/account/account_image.dart';
import 'package:surface/widgets/attachment/attachment_list.dart';
import 'package:surface/widgets/markdown_content.dart';
import 'package:gap/gap.dart';
import 'package:surface/widgets/post/post_comment_list.dart';
import 'package:surface/widgets/post/post_reaction.dart';

class PostItem extends StatelessWidget {
  final SnPost data;
  final bool showReactions;
  final bool showComments;
  final Function(SnPost data)? onChanged;
  const PostItem({
    super.key,
    required this.data,
    this.showReactions = true,
    this.showComments = true,
    this.onChanged,
  });

  void _onChanged(SnPost data) {
    if (onChanged != null) onChanged!(data);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _PostContentHeader(data: data).padding(horizontal: 12, vertical: 8),
        _PostContentBody(data: data.body).padding(horizontal: 16, bottom: 6),
        if (data.preload?.attachments?.isNotEmpty ?? true)
          AttachmentList(
            data: data.preload!.attachments!,
            bordered: true,
          ),
        _PostBottomAction(
          data: data,
          showComments: showComments,
          showReactions: showReactions,
          onChanged: _onChanged,
        ).padding(left: 12, right: 18),
      ],
    );
  }
}

class _PostBottomAction extends StatelessWidget {
  final SnPost data;
  final bool showComments;
  final bool showReactions;
  final Function(SnPost data) onChanged;
  const _PostBottomAction({
    required this.data,
    required this.showComments,
    required this.showReactions,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final iconColor = Theme.of(context).colorScheme.onSurface.withAlpha(
          (255 * 0.8).round(),
        );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            if (showReactions)
              InkWell(
                child: Row(
                  children: [
                    Icon(Symbols.add_reaction, size: 20, color: iconColor),
                    const Gap(8),
                    if (data.totalDownvote > 0 || data.totalUpvote > 0)
                      Text('postReactionPoints').plural(
                        data.totalUpvote - data.totalDownvote,
                      )
                    else
                      Text('postReact').tr(),
                  ],
                ).padding(horizontal: 8, vertical: 8),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => PostReactionPopup(
                      data: data,
                      onChanged: (value, isPositive, delta) {
                        onChanged(data.copyWith(
                          totalUpvote: isPositive
                              ? data.totalUpvote + delta
                              : data.totalUpvote,
                          totalDownvote: !isPositive
                              ? data.totalDownvote + delta
                              : data.totalDownvote,
                          metric: data.metric.copyWith(reactionList: value),
                        ));
                      },
                    ),
                  );
                },
              ),
            if (showComments)
              InkWell(
                child: Row(
                  children: [
                    Icon(Symbols.comment, size: 20, color: iconColor),
                    const Gap(8),
                    Text('postComments').plural(data.metric.replyCount),
                  ],
                ).padding(horizontal: 8, vertical: 8),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    useRootNavigator: true,
                    builder: (context) => PostCommentListPopup(
                      postId: data.id,
                      commentCount: data.metric.replyCount,
                    ),
                  );
                },
              ),
          ].expand((ele) => [ele, const Gap(8)]).toList()
            ..removeLast(),
        ),
        InkWell(
          child: Icon(
            Symbols.share,
            size: 20,
            color: iconColor,
          ).padding(horizontal: 8, vertical: 8),
          onTap: () {},
        ),
      ],
    );
  }
}

class _PostContentHeader extends StatelessWidget {
  final SnPost data;
  const _PostContentHeader({required this.data});

  @override
  Widget build(BuildContext context) {
    final ua = context.read<UserProvider>();
    final isAuthor = ua.isAuthorized && data.publisher.accountId == ua.user!.id;

    return Row(
      children: [
        AccountImage(content: data.publisher.avatar),
        const Gap(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data.publisher.nick).bold(),
              Row(
                children: [
                  Text('@${data.publisher.name}').fontSize(13),
                  const Gap(4),
                  Text(RelativeTime(context).format(
                    data.publishedAt ?? data.createdAt,
                  )).fontSize(13),
                ],
              ).opacity(0.8),
            ],
          ),
        ),
        PopupMenuButton(
          icon: const Icon(Symbols.more_horiz),
          style: const ButtonStyle(
            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
          ),
          itemBuilder: (BuildContext context) => <PopupMenuEntry>[
            if (isAuthor)
              PopupMenuItem(
                child: Row(
                  children: [
                    const Icon(Symbols.edit),
                    const Gap(16),
                    Text('edit').tr(),
                  ],
                ),
                onTap: () {
                  GoRouter.of(context).pushNamed(
                    'postEditor',
                    pathParameters: {'mode': data.typePlural},
                    queryParameters: {'editing': data.id.toString()},
                  );
                },
              ),
            if (isAuthor)
              PopupMenuItem(
                child: Row(
                  children: [
                    const Icon(Symbols.delete),
                    const Gap(16),
                    Text('delete').tr(),
                  ],
                ),
              ),
            if (isAuthor) const PopupMenuDivider(),
            PopupMenuItem(
              child: Row(
                children: [
                  const Icon(Symbols.reply),
                  const Gap(16),
                  Text('reply').tr(),
                ],
              ),
              onTap: () {
                GoRouter.of(context).pushNamed(
                  'postEditor',
                  pathParameters: {'mode': data.typePlural},
                  queryParameters: {'replying': data.id.toString()},
                );
              },
            ),
            PopupMenuItem(
              child: Row(
                children: [
                  const Icon(Symbols.forward),
                  const Gap(16),
                  Text('repost').tr(),
                ],
              ),
              onTap: () {
                GoRouter.of(context).pushNamed(
                  'postEditor',
                  pathParameters: {'mode': data.typePlural},
                  queryParameters: {'reposting': data.id.toString()},
                );
              },
            ),
            const PopupMenuDivider(),
            PopupMenuItem(
              child: Row(
                children: [
                  const Icon(Symbols.flag),
                  const Gap(16),
                  Text('report').tr(),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PostContentBody extends StatelessWidget {
  final dynamic data;
  const _PostContentBody({this.data});

  @override
  Widget build(BuildContext context) {
    if (data['content'] == null) return const SizedBox.shrink();
    return MarkdownTextContent(content: data['content']);
  }
}
