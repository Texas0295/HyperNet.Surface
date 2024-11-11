import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:surface/providers/sn_attachment.dart';
import 'package:surface/providers/sn_network.dart';
import 'package:surface/types/post.dart';
import 'package:surface/widgets/dialog.dart';
import 'package:surface/widgets/loading_indicator.dart';
import 'package:surface/widgets/navigation/app_scaffold.dart';
import 'package:surface/widgets/post/post_comment_list.dart';
import 'package:surface/widgets/post/post_item.dart';

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
      setState(() {
        _data = SnPost.fromJson(resp.data).copyWith(
          preload: SnPostPreload(
            attachments: attachments,
          ),
        );
      });
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

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
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
          children: [
            Text(_data?.body['title'] ?? 'postNoun'.tr())
                .textStyle(Theme.of(context).textTheme.titleLarge!)
                .textColor(Colors.white),
            Text('postDetail')
                .tr()
                .textColor(Colors.white.withAlpha((255 * 0.9).round())),
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
              child: PostItem(data: _data!),
            ),
          const SliverToBoxAdapter(child: Divider(height: 1)),
          if (_data != null)
            SliverToBoxAdapter(
              child: Text('postCommentsDetailed')
                  .plural(_data!.metric.replyCount)
                  .textStyle(Theme.of(context).textTheme.titleLarge!)
                  .padding(horizontal: 16, top: 12, bottom: 4),
            ),
          if (_data != null) PostCommentSliverList(parentPostId: _data!.id),
          SliverGap(math.max(MediaQuery.of(context).padding.bottom, 16)),
        ],
      ),
    );
  }
}
