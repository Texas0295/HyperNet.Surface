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
  final bool showMenu;
  final double? maxWidth;
  final Function(SnPost data)? onChanged;
  const PostItem({
    super.key,
    required this.data,
    this.showReactions = true,
    this.showComments = true,
    this.showMenu = true,
    this.maxWidth,
    this.onChanged,
  });

  void _onChanged(SnPost data) {
    if (onChanged != null) onChanged!(data);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: maxWidth ?? double.infinity),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _PostContentHeader(data: data, showMenu: showMenu)
                  .padding(horizontal: 12, vertical: 8),
              if (data.body['title'] != null ||
                  data.body['description'] != null)
                _PostHeadline(data: data).padding(horizontal: 16, bottom: 8),
              _PostContentBody(data: data.body)
                  .padding(horizontal: 16, bottom: 6),
              if (data.repostTo != null)
                _PostQuoteContent(child: data.repostTo!).padding(
                  horizontal: 12,
                ),
              if (data.body['content_truncated'] == true)
                _PostTruncatedHint(data: data).padding(
                  horizontal: 16,
                  vertical: 4,
                ),
              if (data.tags.isNotEmpty)
                _PostTagsList(data: data).padding(horizontal: 16, bottom: 6),
            ],
          ),
        ),
        if (data.preload?.attachments?.isNotEmpty ?? false)
          AttachmentList(
            data: data.preload!.attachments!,
            bordered: true,
            maxHeight: 480,
            listPadding: const EdgeInsets.symmetric(horizontal: 12),
          ),
        Container(
          constraints: BoxConstraints(maxWidth: maxWidth ?? double.infinity),
          child: Column(
            children: [
              _PostBottomAction(
                data: data,
                showComments: showComments,
                showReactions: showReactions,
                onChanged: _onChanged,
              ).padding(left: 8, right: 14),
            ],
          ),
        ),
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
        if (showReactions || showComments)
          Row(
            children: [
              if (showReactions)
                InkWell(
                  child: Row(
                    children: [
                      Icon(Symbols.add_reaction, size: 20, color: iconColor),
                      const Gap(8),
                      if (data.totalUpvote > 0 &&
                          data.totalUpvote >= data.totalDownvote)
                        Text('postReactionUpvote').plural(
                          data.totalUpvote,
                        )
                      else if (data.totalDownvote > 0)
                        Text('postReactionDownvote').plural(
                          data.totalDownvote,
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
                        onChanged: (value, attr, delta) {
                          onChanged(data.copyWith(
                            totalUpvote: attr == 1
                                ? data.totalUpvote + delta
                                : data.totalUpvote,
                            totalDownvote: attr == 2
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

class _PostHeadline extends StatelessWidget {
  final SnPost data;
  const _PostHeadline({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (data.body['title'] != null)
          Text(
            data.body['title'],
            style: Theme.of(context).textTheme.titleMedium,
          ),
        if (data.body['description'] != null)
          Text(
            data.body['description'],
            style: Theme.of(context).textTheme.bodyMedium,
          ),
      ],
    );
  }
}

class _PostContentHeader extends StatelessWidget {
  final SnPost data;
  final bool isCompact;
  final bool showMenu;
  const _PostContentHeader({
    required this.data,
    this.isCompact = false,
    this.showMenu = true,
  });

  @override
  Widget build(BuildContext context) {
    final ua = context.read<UserProvider>();
    final isAuthor = ua.isAuthorized && data.publisher.accountId == ua.user!.id;

    return Row(
      children: [
        AccountImage(
          content: data.publisher.avatar,
          radius: isCompact ? 12 : 20,
        ),
        Gap(isCompact ? 8 : 12),
        if (isCompact)
          Row(
            children: [
              Text(data.publisher.nick).bold(),
              const Gap(4),
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
          )
        else
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
        if (showMenu)
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
                    Text('replyPost').tr(),
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

class _PostQuoteContent extends StatelessWidget {
  final SnPost child;
  const _PostQuoteContent({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        border: Border.all(
          color: Theme.of(context).dividerColor,
          width: 1,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          _PostContentHeader(data: child, isCompact: true, showMenu: false)
              .padding(bottom: 4),
          _PostContentBody(data: child.body),
        ],
      ),
    );
  }
}

class _PostTagsList extends StatelessWidget {
  final SnPost data;
  const _PostTagsList({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: data.tags
          .map(
            (ele) => InkWell(
              child: Text(
                '#${ele.alias}',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ).fontSize(13),
              onTap: () {},
            ),
          )
          .toList(),
    ).opacity(0.8);
  }
}

class _PostTruncatedHint extends StatelessWidget {
  final SnPost data;
  const _PostTruncatedHint({super.key, required this.data});

  static const int kHumanReadSpeed = 238;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (data.body['content_length'] != null)
          Row(
            children: [
              const Icon(Symbols.timer, size: 20),
              const Gap(4),
              Text('postReadEstimate').tr(args: [
                '${Duration(
                  seconds: ((data.body['content_length'] as num).toDouble() /
                          kHumanReadSpeed)
                      .round(),
                ).inSeconds}s',
              ]),
            ],
          ).padding(right: 12),
        if (data.body['content_length'] != null)
          Row(
            children: [
              const Icon(Symbols.height, size: 20),
              const Gap(4),
              Text(
                'postTotalLength'.plural(data.body['content_length']),
              ).padding(right: 12)
            ],
          ),
        Row(
          children: [
            const Icon(Symbols.unfold_more, size: 20),
            const Gap(4),
            Text('postReadMore').tr(),
          ],
        )
      ],
    ).opacity(0.75);
  }
}
