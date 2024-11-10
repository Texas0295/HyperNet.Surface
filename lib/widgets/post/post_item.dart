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

class PostItem extends StatelessWidget {
  final SnPost data;
  const PostItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _PostContentHeader(data: data).padding(horizontal: 12, vertical: 8),
        _PostContentBody(data: data.body).padding(horizontal: 16, bottom: 6),
        if (data.preload?.attachments?.isNotEmpty ?? true)
          AttachmentList(data: data.preload!.attachments!, bordered: true),
        _PostBottomAction(data: data)
            .padding(left: 20, right: 26, top: 8, bottom: 2),
      ],
    );
  }
}

class _PostBottomAction extends StatelessWidget {
  final SnPost data;
  const _PostBottomAction({super.key, required this.data});

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
            InkWell(
              child: Row(
                children: [
                  Icon(Symbols.add_reaction, size: 20, color: iconColor),
                  const Gap(8),
                  Text('postReact').tr(),
                ],
              ),
              onTap: () {},
            ),
            const Gap(16),
            InkWell(
              child: Row(
                children: [
                  Icon(Symbols.comment, size: 20, color: iconColor),
                  const Gap(8),
                  Text('postComments').plural(data.metric.replyCount),
                ],
              ),
              onTap: () {},
            ),
          ].expand((ele) => [ele, const Gap(8)]).toList()
            ..removeLast(),
        ),
        InkWell(
          child: Icon(Symbols.share, size: 20, color: iconColor),
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
