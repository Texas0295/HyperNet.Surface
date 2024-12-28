import 'dart:io';
import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:path_provider/path_provider.dart';
import 'package:popover/popover.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:relative_time/relative_time.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:surface/providers/config.dart';
import 'package:surface/providers/sn_network.dart';
import 'package:surface/providers/userinfo.dart';
import 'package:surface/types/post.dart';
import 'package:surface/types/reaction.dart';
import 'package:surface/widgets/account/account_image.dart';
import 'package:surface/widgets/attachment/attachment_list.dart';
import 'package:surface/widgets/dialog.dart';
import 'package:surface/widgets/link_preview.dart';
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

  void _doShare(BuildContext context) {
    final box = context.findRenderObject() as RenderBox?;
    final url = 'https://solsynth.dev/posts/${data.id}';
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      Share.shareUri(Uri.parse(url), sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    } else {
      Share.share(url, sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    }
  }

  void _doShareViaPicture(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    context.showSnackbar('postSharingViaPicture'.tr());

    final controller = ScreenshotController();
    final capturedImage = await controller.captureFromLongWidget(
      InheritedTheme.captureAll(
        context,
        MediaQuery(
          data: MediaQuery.of(context),
          child: Material(
            child: MultiProvider(
              providers: [
                Provider<SnNetworkProvider>(create: (_) => context.read()),
                ChangeNotifierProvider<ConfigProvider>(create: (_) => context.read()),
              ],
              child: ResponsiveBreakpoints.builder(
                breakpoints: ResponsiveBreakpoints.of(context).breakpoints,
                child: PostShareImageWidget(data: data),
              ),
            ),
          ),
        ),
      ),
      pixelRatio: 3,
      context: context,
    );

    if (kIsWeb) return;

    final directory = await getTemporaryDirectory();
    final imageFile = await File(
      '${directory.path}/sn-share-via-image-${DateTime.now().millisecondsSinceEpoch}.png',
    ).create();
    await imageFile.writeAsBytes(capturedImage);

    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      await Share.shareXFiles(
        [XFile(imageFile.path)],
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      );
    } else {
      await FileSaver.instance.saveFile(name: 'Solar Network Post #${data.id}', file: imageFile);
    }

    await imageFile.delete();
  }

  @override
  Widget build(BuildContext context) {
    final sn = context.read<SnNetworkProvider>();

    final ua = context.read<UserProvider>();
    final isAuthor = ua.isAuthorized && data.publisher.accountId == ua.user?.id;

    // Article headline preview
    if (!showFullPost && data.type == 'article') {
      return Container(
        constraints: BoxConstraints(maxWidth: maxWidth ?? double.infinity),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _PostContentHeader(
              data: data,
              isAuthor: isAuthor,
              isRelativeDate: !showFullPost,
              onShare: () => _doShare(context),
              onShareImage: () => _doShareViaPicture(context),
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
                      if (data.tags.isNotEmpty) _PostTagsList(data: data),
                    ],
                  ).padding(horizontal: 12),
                  const Gap(8),
                ],
              ),
            ),
            Text('postArticle').tr().fontSize(13).opacity(0.75).padding(horizontal: 24, bottom: 8),
            _PostBottomAction(
              data: data,
              showComments: showComments,
              showReactions: showReactions,
              onShare: () => _doShare(context),
              onShareImage: () => _doShareViaPicture(context),
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
                isAuthor: isAuthor,
                isRelativeDate: !showFullPost,
                data: data,
                showMenu: showMenu,
                onShare: () => _doShare(context),
                onShareImage: () => _doShareViaPicture(context),
                onDeleted: () {
                  if (onDeleted != null) onDeleted!();
                },
              ).padding(horizontal: 12, vertical: 8),
              if (data.body['title'] != null || data.body['description'] != null)
                _PostHeadline(
                  data: data,
                  isEnlarge: data.type == 'article' && showFullPost,
                ).padding(horizontal: 16, bottom: 8),
              if (data.body['content']?.isNotEmpty ?? false)
                _PostContentBody(
                  data: data,
                  isSelectable: showFullPost,
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
              if (data.tags.isNotEmpty) _PostTagsList(data: data).padding(horizontal: 16, top: 4, bottom: 6),
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
        if (data.body['content'] != null)
          LinkPreviewWidget(
            text: data.body['content'],
          ).padding(horizontal: 4),
        Container(
          constraints: BoxConstraints(maxWidth: maxWidth ?? double.infinity),
          child: Column(
            children: [
              _PostBottomAction(
                data: data,
                showComments: showComments,
                showReactions: showReactions,
                onShare: () => _doShare(context),
                onShareImage: () => _doShareViaPicture(context),
                onChanged: _onChanged,
              ).padding(left: 8, right: 14),
            ],
          ),
        ),
      ],
    );
  }
}

class PostShareImageWidget extends StatelessWidget {
  const PostShareImageWidget({
    super.key,
    required this.data,
  });

  final SnPost data;

  @override
  Widget build(BuildContext context) {
    final sn = context.read<SnNetworkProvider>();

    return SizedBox(
      width: 480,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
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
            ).padding(bottom: 8),
          _PostContentHeader(
            isAuthor: false,
            data: data,
            onDeleted: () {},
            onShare: () {},
            onShareImage: () {},
            showMenu: false,
            isRelativeDate: false,
          ).padding(horizontal: 16, bottom: 8),
          _PostHeadline(
            data: data,
            isEnlarge: data.type == 'article',
          ).padding(horizontal: 16, bottom: 8),
          if (data.body['content']?.isNotEmpty ?? false)
            _PostContentBody(
              data: data,
              isEnlarge: data.type == 'article',
            ).padding(horizontal: 16, bottom: 8),
          if (data.repostTo != null)
            _PostQuoteContent(
              child: data.repostTo!,
              isRelativeDate: false,
              isFlatted: true,
            ).padding(horizontal: 16, bottom: 8),
          if (data.type != 'article' && (data.preload?.attachments?.isNotEmpty ?? false))
            AttachmentList(
              data: data.preload!.attachments!,
              isFlatted: true,
            ).padding(horizontal: 16, bottom: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (data.visibility > 0) _PostVisibilityHint(data: data),
              if (data.body['content_truncated'] == true) _PostTruncatedHint(data: data),
            ],
          ).padding(horizontal: 16),
          _PostBottomAction(
            data: data,
            showComments: true,
            showReactions: true,
            onShare: () {},
            onShareImage: () {},
            onChanged: (SnPost data) {},
          ).padding(left: 8, right: 14),
          const Divider(height: 1),
          const Gap(12),
          SizedBox(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${data.aliasPrefix} / ${data.alias ?? '#${data.id}'}',
                              style: GoogleFonts.robotoMono(fontSize: 17),
                            ),
                            const Gap(2),
                            Text(
                              switch (data.type) {
                                'article' => 'postArticle'.tr(),
                                _ => 'postStory'.tr(),
                              },
                              style: GoogleFonts.robotoMono(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      if (data.body['content_truncated'] == true)
                        Text(
                          'postImageShareReadMore'.tr(),
                          style: GoogleFonts.robotoMono(fontSize: 11),
                        ),
                      Text(
                        'postImageShareAds',
                        style: GoogleFonts.robotoMono(fontSize: 13),
                      ).tr(),
                    ],
                  ),
                ),
                QrImageView(
                  padding: EdgeInsets.zero,
                  data: 'https://solsynth.dev/posts/${data.id}',
                  errorCorrectionLevel: QrErrorCorrectLevel.H,
                  version: QrVersions.auto,
                  size: 100,
                  gapless: true,
                  embeddedImage: AssetImage('assets/icon/icon-light-radius.png'),
                  embeddedImageStyle: QrEmbeddedImageStyle(
                    size: Size(28, 28),
                  ),
                  eyeStyle: QrEyeStyle(
                    eyeShape: QrEyeShape.circle,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  dataModuleStyle: QrDataModuleStyle(
                    dataModuleShape: QrDataModuleShape.square,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                )
              ],
            ),
          ).padding(left: 16, right: 32, vertical: 8),
        ],
      ).padding(vertical: 16),
    );
  }
}

class _PostBottomAction extends StatelessWidget {
  final SnPost data;
  final bool showComments;
  final bool showReactions;
  final Function(SnPost data) onChanged;
  final Function() onShare, onShareImage;

  const _PostBottomAction({
    required this.data,
    required this.showComments,
    required this.showReactions,
    required this.onChanged,
    required this.onShare,
    required this.onShareImage,
  });

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
            spacing: 8,
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
            ],
          ),
        InkWell(
          onTap: onShare,
          onLongPress: onShareImage,
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
              if (data.editedAt != null)
                Text(
                  'articleEditedAt'.tr(
                    args: [DateFormat('y/M/d HH:mm').format(data.editedAt!)],
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
  final bool isAuthor;
  final bool isCompact;
  final bool isRelativeDate;
  final bool showMenu;
  final Function onDeleted;
  final Function() onShare, onShareImage;

  const _PostContentHeader({
    required this.data,
    required this.isAuthor,
    this.isCompact = false,
    this.isRelativeDate = true,
    this.showMenu = true,
    required this.onDeleted,
    required this.onShare,
    required this.onShareImage,
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
                  Text(
                    isRelativeDate
                        ? RelativeTime(context).format(data.publishedAt ?? data.createdAt)
                        : DateFormat('y/M/d HH:mm').format(data.publishedAt ?? data.createdAt),
                  ).fontSize(13),
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
                    Text(
                      isRelativeDate
                          ? RelativeTime(context).format(data.publishedAt ?? data.createdAt)
                          : DateFormat('y/M/d HH:mm').format(data.publishedAt ?? data.createdAt),
                    ).fontSize(13),
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
                onTap: onShare,
                child: Row(
                  children: [
                    const Icon(Symbols.share),
                    const Gap(16),
                    Text('postShare').tr(),
                  ],
                ),
              ),
              PopupMenuItem(
                onTap: onShareImage,
                child: Row(
                  children: [
                    const Icon(Symbols.share_reviews),
                    const Gap(16),
                    Text('postShareImage').tr(),
                  ],
                ),
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
  final bool isSelectable;

  const _PostContentBody({
    required this.data,
    this.isEnlarge = false,
    this.isSelectable = false,
  });

  @override
  Widget build(BuildContext context) {
    if (data.body['content'] == null) return const SizedBox.shrink();
    return MarkdownTextContent(
      isSelectable: isSelectable,
      textScaler: isEnlarge ? TextScaler.linear(1.1) : null,
      content: data.body['content'],
      attachments: data.preload?.attachments,
    );
  }
}

class _PostQuoteContent extends StatelessWidget {
  final SnPost child;
  final bool isRelativeDate;
  final bool isFlatted;

  const _PostQuoteContent({
    this.isRelativeDate = true,
    this.isFlatted = false,
    required this.child,
  });

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
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          children: [
            Column(
              children: [
                _PostContentHeader(
                  isAuthor: false,
                  data: child,
                  isCompact: true,
                  isRelativeDate: isRelativeDate,
                  showMenu: false,
                  onShare: () {},
                  onShareImage: () {},
                  onDeleted: () {},
                ).padding(bottom: 4),
                _PostContentBody(data: child),
                if (child.visibility > 0) _PostVisibilityHint(data: child).padding(top: 4),
              ],
            ).padding(horizontal: 16),
            if (child.type != 'article' && (child.preload?.attachments?.isNotEmpty ?? false))
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                child: AttachmentList(
                  data: child.preload!.attachments!,
                  isFlatted: isFlatted,
                  listPadding: const EdgeInsets.symmetric(horizontal: 12),
                ),
              ).padding(
                top: 8,
                bottom: (child.preload?.attachments?.length ?? 0) > 1 ? 12 : 0,
              )
            else
              const Gap(8),
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

  const _PostTagsList({required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 4,
          runSpacing: 4,
          children: data.categories
              .map(
                (ele) => InkWell(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Symbols.category, size: 20),
                      const Gap(4),
                      Text(
                        'postCategory${ele.alias.capitalize()}'.trExists()
                            ? 'postCategory${ele.alias.capitalize()}'.tr()
                            : ele.alias,
                        style: GoogleFonts.robotoMono(),
                      ),
                    ],
                  ),
                  onTap: () {
                    GoRouter.of(context).pushNamed(
                      'postSearch',
                      queryParameters: {
                        'categories': ele.alias,
                      },
                    );
                  },
                ),
              )
              .toList(),
        ).opacity(0.8),
        Wrap(
          spacing: 4,
          runSpacing: 4,
          children: data.tags
              .map(
                (ele) => InkWell(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Symbols.label, size: 20),
                      const Gap(4),
                      Text(ele.alias, style: GoogleFonts.robotoMono()),
                    ],
                  ),
                  onTap: () {
                    GoRouter.of(context).pushNamed(
                      'postSearch',
                      queryParameters: {
                        'tags': ele.alias,
                      },
                    );
                  },
                ),
              )
              .toList(),
        ).opacity(0.8),
      ],
    );
  }
}

class _PostVisibilityHint extends StatelessWidget {
  final SnPost data;

  const _PostVisibilityHint({required this.data});

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

  const _PostTruncatedHint({required this.data});

  static const int kHumanReadSpeed = 238;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 8,
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
            ),
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
      ).opacity(0.75),
    );
  }
}

class _PostAbuseReportDialog extends StatefulWidget {
  final SnPost data;

  const _PostAbuseReportDialog({required this.data});

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
