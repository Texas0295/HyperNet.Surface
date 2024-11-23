import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:surface/providers/sn_attachment.dart';
import 'package:surface/providers/sn_network.dart';
import 'package:surface/providers/userinfo.dart';
import 'package:surface/types/post.dart';
import 'package:surface/widgets/dialog.dart';
import 'package:surface/widgets/loading_indicator.dart';
import 'package:surface/widgets/post/post_comment_list.dart';
import 'package:surface/widgets/post/post_item.dart';
import 'package:surface/widgets/post/post_mini_editor.dart';

class PostDetailScreen extends StatefulWidget {
  final String slug;
  final SnPost? preload;
  const PostDetailScreen({
    super.key,
    required this.slug,
    this.preload,
  });

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  bool _isBusy = false;

  SnPost? _data;

  void _fetchPost() async {
    setState(() => _isBusy = true);

    try {
      final sn = context.read<SnNetworkProvider>();
      final attach = context.read<SnAttachmentProvider>();
      final resp = await sn.client.get('/cgi/co/posts/${widget.slug}');
      if (!mounted) return;
      final attachments = await attach.getMultiple(
        resp.data['body']['attachments']?.cast<String>() ?? [],
      );
      if (!mounted) return;
      _data = SnPost.fromJson(resp.data).copyWith(
        preload: SnPostPreload(
          attachments: attachments,
        ),
      );
    } catch (err) {
      context.showErrorDialog(err);
    } finally {
      setState(() => _isBusy = false);
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.preload != null) {
      _data = widget.preload;
    }
    _fetchPost();
  }

  final GlobalKey<PostCommentSliverListState> _childListKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final ua = context.watch<UserProvider>();
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            if (GoRouter.of(context).canPop()) {
              Navigator.pop(context);
            }
            GoRouter.of(context).replaceNamed('explore');
          },
        ),
        flexibleSpace: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_data?.body['title'] != null)
              Text(_data?.body['title'] ?? 'postNoun'.tr())
                  .textStyle(Theme.of(context).textTheme.titleLarge!)
                  .textColor(Colors.white),
            if (_data?.body['title'] != null)
              Text('postDetail'.tr())
                  .textColor(Colors.white.withAlpha((255 * 0.9).round()))
            else
              Text('postDetail'.tr())
                  .textStyle(Theme.of(context).textTheme.titleLarge!)
                  .textColor(Colors.white),
          ],
        ).padding(top: math.max(MediaQuery.of(context).padding.top, 8)),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: LoadingIndicator(isActive: _isBusy),
          ),
          if (_data != null)
            SliverToBoxAdapter(
              child: PostItem(
                data: _data!,
                maxWidth: 640,
                showComments: false,
                onChanged: (data) {
                  setState(() => _data = data);
                },
              ),
            ),
          const SliverToBoxAdapter(child: Divider(height: 1)),
          if (_data != null)
            SliverToBoxAdapter(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Symbols.comment, size: 24),
                  const Gap(16),
                  Text('postCommentsDetailed')
                      .plural(_data!.metric.replyCount)
                      .textStyle(Theme.of(context).textTheme.titleLarge!),
                ],
              ).padding(horizontal: 20, vertical: 12),
            ),
          if (_data != null && ua.isAuthorized)
            SliverToBoxAdapter(
              child: Container(
                height: 240,
                decoration: BoxDecoration(
                  border: Border.symmetric(
                    horizontal: BorderSide(
                      color: Theme.of(context).dividerColor,
                      width: 1 / devicePixelRatio,
                    ),
                  ),
                ),
                child: PostMiniEditor(
                  postReplyId: _data!.id,
                  onPost: () {
                    setState(() {
                      _data = _data!.copyWith(
                        metric: _data!.metric.copyWith(
                          replyCount: _data!.metric.replyCount + 1,
                        ),
                      );
                    });
                    _childListKey.currentState!.refresh();
                  },
                ),
              ),
            ),
          if (_data != null)
            PostCommentSliverList(
              key: _childListKey,
              parentPostId: _data!.id,
              maxWidth: 640,
            ),
          SliverGap(math.max(MediaQuery.of(context).padding.bottom, 16)),
        ],
      ),
    );
  }
}
