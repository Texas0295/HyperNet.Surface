import 'dart:io';
import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:popover/popover.dart';
import 'package:provider/provider.dart';
import 'package:relative_time/relative_time.dart';
import 'package:share_plus/share_plus.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:surface/providers/sn_network.dart';
import 'package:surface/providers/userinfo.dart';
import 'package:surface/types/post.dart';
import 'package:surface/types/reaction.dart';
import 'package:surface/widgets/account/account_image.dart';
import 'package:surface/widgets/attachment/attachment_list.dart';
import 'package:surface/widgets/dialog.dart';
import 'package:surface/widgets/markdown_content.dart';
import 'package:gap/gap.dart';
import 'package:surface/widgets/post/post_comment_list.dart';
import 'package:surface/widgets/post/post_meta_editor.dart';
import 'package:surface/widgets/post/post_reaction.dart';
import 'package:surface/widgets/post/publisher_popover.dart';
import 'package:surface/widgets/universal_image.dart';

class PostItem extends StatelessWidget {
  final SnPost data;
  final bool showReactions;
  final bool showComments;
  final bool showMenu;
  final bool showFullPost;
  final double? maxWidth;
  final Function(SnPost data)? onChanged;
  final Function()? onDeleted;

  const PostItem({
    super.key,
    required this.data,
    this.showReactions = true,
    this.showComments = true,
    this.showMenu = true,
    this.showFullPost = false,
    this.maxWidth,
    this.onChanged,
    this.onDeleted,
  });

  void _onChanged(SnPost data) {
    if (onChanged != null) onChanged!(data);
  }

  @override
  Widget build(BuildContext context) {
    final sn = context.read<SnNetworkProvider>();

    // Article headline preview
    if (!showFullPost && data.type == 'article') {
      return Container(
        constraints: BoxConstraints(maxWidth: maxWidth ?? double.infinity),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _PostContentHeader(
              data: data,
              onDeleted: () {
                if (onDeleted != null) {}
              },
            ).padding(horizontal: 12, top: 8, bottom: 8),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 4, left: 12, right: 12),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                border: Border.all(
                  color: Theme.of(context).dividerColor,
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (data.preload?.thumbnail != null)
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                        child: AutoResizeUniversalImage(
                          sn.getAttachmentUrl(data.preload!.thumbnail!.rid),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  const Gap(8),
                  _PostHeadline(data: data).padding(horizontal: 14),
                  const Gap(4),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (data.visibility > 0) _PostVisibilityHint(data: data),
                      _PostTruncatedHint(data: data),
                    ],
                  ).padding(horizontal: 12),
                  const Gap(8),
                ],
              ),
            ),
            Text('postArticle').tr().fontSize(13).opacity(0.75).padding(horizontal: 24, bottom: 8),
            if (data.tags.isNotEmpty) _PostTagsList(data: data).padding(horizontal: 16, bottom: 6),
            _PostBottomAction(
              data: data,
              showComments: showComments,
              showReactions: showReactions,
              onChanged: _onChanged,
            ).padding(left: 8, right: 14),
          ],
        ),
      ).center();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: maxWidth ?? double.infinity),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _PostContentHeader(
                data: data,
                showMenu: showMenu,
                onDeleted: () {
                  if (onDeleted != null) onDeleted!();
                },
              ).padding(horizontal: 12, vertical: 8),
              if (data.body['title'] != null || data.body['description'] != null)
                _PostHeadline(
                  data: data,
                  isEnlarge: data.type == 'article' && showFullPost,
                ).padding(horizontal: 16, bottom: 8),
              _PostContentBody(
                data: data,
                isEnlarge: data.type == 'article' && showFullPost,
              ).padding(horizontal: 16, bottom: 6),
              if (data.repostTo != null)
                _PostQuoteContent(child: data.repostTo!).padding(
                  horizontal: 12,
                  bottom: data.preload?.attachments?.isNotEmpty ?? false ? 12 : 0,
                ),
              if (data.visibility > 0)
                _PostVisibilityHint(data: data).padding(
                  horizontal: 16,
                  vertical: 4,
                ),
              if (data.body['content_truncated'] == true)
                _PostTruncatedHint(data: data).padding(
                  horizontal: 16,
                  vertical: 4,
                ),
              if (data.tags.isNotEmpty) _PostTagsList(data: data).padding(horizontal: 16, bottom: 6),
            ],
          ),
        ),
        if ((data.preload?.attachments?.isNotEmpty ?? false) && data.type != 'article')
          AttachmentList(
            data: data.preload!.attachments!,
            bordered: true,
            maxHeight: 560,
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

  void _doShare() {
    final url = 'https://solsynth.dev/posts/${data.id}';
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      Share.shareUri(Uri.parse(url));
    } else {
      Share.share(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    final iconColor = Theme.of(context).colorScheme.onSurface.withAlpha(
          (255 * 0.8).round(),
        );

    final String? mostTypicalReaction = data.metric.reactionList.isNotEmpty
        ? data.metric.reactionList.entries.reduce((a, b) => a.value > b.value ? a : b).key
        : null;

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
                      if (mostTypicalReaction == null || kTemplateReactions[mostTypicalReaction] == null)
                        Icon(Symbols.add_reaction, size: 20, color: iconColor)
                      else
                        Text(
                          kTemplateReactions[mostTypicalReaction]!.icon,
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.2,
                            letterSpacing: 0,
                          ),
                        ),
                      const Gap(8),
                      if (data.totalUpvote > 0 && data.totalUpvote >= data.totalDownvote)
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
                            totalUpvote: attr == 1 ? data.totalUpvote + delta : data.totalUpvote,
                            totalDownvote: attr == 2 ? data.totalDownvote + delta : data.totalDownvote,
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
          onTap: _doShare,
          child: Icon(
            Symbols.share,
            size: 20,
            color: iconColor,
          ).padding(horizontal: 8, vertical: 8),
        ),
      ],
    );
  }
}

class _PostHeadline extends StatelessWidget {
  final SnPost data;
  final bool isEnlarge;

  const _PostHeadline({
    super.key,
    required this.data,
    this.isEnlarge = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isEnlarge) {
      final sn = context.read<SnNetworkProvider>();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (data.preload?.thumbnail != null)
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                border: Border.all(
                  color: Theme.of(context).dividerColor,
                  width: 1,
                ),
              ),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: AutoResizeUniversalImage(
                    sn.getAttachmentUrl(data.preload!.thumbnail!.rid),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          if (data.body['title'] != null)
            Text(
              data.body['title'],
              style: Theme.of(context).textTheme.titleMedium,
              textScaler: TextScaler.linear(1.4),
            ),
          if (data.body['description'] != null)
            Text(
              data.body['description'],
              style: Theme.of(context).textTheme.bodyMedium,
              textScaler: TextScaler.linear(1.1),
            ),
          if (data.body['description'] != null) const Gap(8) else const Gap(4),
          Row(
            children: [
              Text(
                'articleWrittenAt'.tr(
                  args: [DateFormat('y/M/d HH:mm').format(data.createdAt)],
                ),
                style: TextStyle(fontSize: 13),
              ),
              const Gap(8),
              if (data.updatedAt != data.createdAt)
                Text(
                  'articleEditedAt'.tr(
                    args: [DateFormat('y/M/d HH:mm').format(data.updatedAt)],
                  ),
                  style: TextStyle(fontSize: 13),
                ),
            ],
          ).opacity(0.75),
          const Gap(8),
          const Divider(height: 1, thickness: 1),
          const Gap(8),
        ],
      );
    }

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
  final Function onDeleted;

  const _PostContentHeader({
    required this.data,
    this.isCompact = false,
    this.showMenu = true,
    required this.onDeleted,
  });

  Future<void> _deletePost(BuildContext context) async {
    final confirm = await context.showConfirmDialog(
      'postDelete'.tr(args: ['#${data.id}']),
      'postDeleteDescription'.tr(),
    );

    if (!confirm) return;
    if (!context.mounted) return;

    try {
      final sn = context.read<SnNetworkProvider>();
      await sn.client.delete('/cgi/co/posts/${data.id}', queryParameters: {
        'publisherId': data.publisherId,
      });

      if (!context.mounted) return;
      context.showSnackbar('postDeleted'.tr(args: ['#${data.id}']));
    } catch (err) {
      if (!context.mounted) return;
      context.showErrorDialog(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ua = context.read<UserProvider>();
    final isAuthor = ua.isAuthorized && data.publisher.accountId == ua.user!.id;

    return Row(
      children: [
        GestureDetector(
          child: AccountImage(
            content: data.publisher.avatar,
            radius: isCompact ? 12 : 20,
          ),
          onTap: () {
            showPopover(
              backgroundColor: Theme.of(context).colorScheme.surface,
              context: context,
              transition: PopoverTransition.other,
              bodyBuilder: (context) => SizedBox(
                width: math.min(400, MediaQuery.of(context).size.width - 10),
                child: PublisherPopoverCard(
                  data: data.publisher,
                ),
              ),
              direction: PopoverDirection.bottom,
              arrowHeight: 5,
              arrowWidth: 15,
              arrowDxOffset: -190,
            );
          },
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
                  onTap: () => _deletePost(context),
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
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => _PostAbuseReportDialog(
                      data: data,
                    ),
                  ).then((value) {
                    if (value == true && context.mounted) {
                      context.showSnackbar('abuseReportSubmitted'.tr());
                    }
                  });
                },
              ),
            ],
          ),
      ],
    );
  }
}

class _PostContentBody extends StatelessWidget {
  final SnPost data;
  final bool isEnlarge;

  const _PostContentBody({
    required this.data,
    this.isEnlarge = false,
  });

  @override
  Widget build(BuildContext context) {
    if (data.body['content'] == null) return const SizedBox.shrink();
    return MarkdownTextContent(
      textScaler: isEnlarge ? TextScaler.linear(1.1) : null,
      content: data.body['content'],
      attachments: data.preload?.attachments,
    );
  }
}

class _PostQuoteContent extends StatelessWidget {
  final SnPost child;

  const _PostQuoteContent({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
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
            _PostContentHeader(
              data: child,
              isCompact: true,
              showMenu: false,
              onDeleted: () {},
            ).padding(bottom: 4),
            _PostContentBody(data: child),
          ],
        ),
      ),
      onTap: () {
        GoRouter.of(context).pushNamed('postDetail', pathParameters: {
          'slug': child.id.toString(),
        });
      },
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

class _PostVisibilityHint extends StatelessWidget {
  final SnPost data;

  const _PostVisibilityHint({super.key, required this.data});

  static const List<IconData> kVisibilityIcons = [
    Symbols.public,
    Symbols.group,
    Symbols.person_check,
    Symbols.person_remove,
    Symbols.lock,
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(kVisibilityIcons[data.visibility], size: 20),
        const Gap(4),
        Text(kPostVisibilityLevel[data.visibility] ?? 'postVisibilityAll').tr(),
      ],
    ).opacity(0.75);
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
                  seconds: (data.body['content_length'] as num).toDouble() * 60 ~/ kHumanReadSpeed,
                ).inSeconds}s',
              ]),
            ],
          ).padding(right: 8),
        if (data.body['content_length'] != null)
          Row(
            children: [
              const Icon(Symbols.height, size: 20),
              const Gap(4),
              Text(
                'postTotalLength'.plural(data.body['content_length']),
              )
            ],
          ),
      ],
    ).opacity(0.75);
  }
}

class _PostAbuseReportDialog extends StatefulWidget {
  final SnPost data;

  const _PostAbuseReportDialog({super.key, required this.data});

  @override
  State<_PostAbuseReportDialog> createState() => _PostAbuseReportDialogState();
}

class _PostAbuseReportDialogState extends State<_PostAbuseReportDialog> {
  bool _isBusy = false;

  final _reasonController = TextEditingController();

  @override
  dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _performAction() async {
    setState(() => _isBusy = true);
    try {
      final sn = context.read<SnNetworkProvider>();
      await sn.client.post(
        '/cgi/id/reports/abuse',
        data: {
          'resource': 'post:${widget.data.id}',
          'reason': _reasonController.text,
        },
      );
      if (!mounted) return;
      Navigator.pop(context, true);
    } catch (err) {
      if (!mounted) return;
      context.showErrorDialog(err);
    } finally {
      setState(() => _isBusy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('postAbuseReport'.tr()),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('postAbuseReportDescription'.tr()),
          const Gap(12),
          TextField(
            controller: _reasonController,
            maxLength: null,
            decoration: InputDecoration(
              border: const UnderlineInputBorder(),
              labelText: 'abuseReportReason'.tr(),
            ),
            onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _isBusy ? null : () => Navigator.pop(context),
          child: Text('dialogDismiss').tr(),
        ),
        TextButton(
          onPressed: _isBusy ? null : _performAction,
          child: Text('submit').tr(),
        ),
      ],
    );
  }
}
