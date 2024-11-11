import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:surface/providers/sn_attachment.dart';
import 'package:surface/providers/sn_network.dart';
import 'package:surface/types/post.dart';
import 'package:surface/widgets/post/post_item.dart';
import 'package:very_good_infinite_list/very_good_infinite_list.dart';

class PostCommentSliverList extends StatefulWidget {
  final int parentPostId;
  const PostCommentSliverList({super.key, required this.parentPostId});

  @override
  State<PostCommentSliverList> createState() => _PostCommentSliverListState();
}

class _PostCommentSliverListState extends State<PostCommentSliverList> {
  bool _isBusy = true;

  final List<SnPost> _posts = List.empty(growable: true);
  int? _postCount;

  Future<void> _fetchPosts() async {
    if (_postCount != null && _posts.length >= _postCount!) return;

    setState(() => _isBusy = true);

    final sn = context.read<SnNetworkProvider>();
    final resp = await sn.client.get(
      '/cgi/co/posts/${widget.parentPostId}/replies',
      queryParameters: {
        'take': 10,
        'offset': _posts.length,
      },
    );
    final List<SnPost> out =
        List.from(resp.data['data']?.map((e) => SnPost.fromJson(e)) ?? []);

    Set<String> rids = {};
    for (var i = 0; i < out.length; i++) {
      rids.addAll(out[i].body['attachments']?.cast<String>() ?? []);
    }

    if (!mounted) return;
    final attach = context.read<SnAttachmentProvider>();
    final attachments = await attach.getMultiple(rids.toList());
    for (var i = 0; i < out.length; i++) {
      out[i] = out[i].copyWith(
        preload: SnPostPreload(
          attachments: attachments
              .where(
                (ele) => out[i].body['attachments']?.contains(ele.rid) ?? false,
              )
              .toList(),
        ),
      );
    }

    _postCount = resp.data['count'];
    _posts.addAll(out);

    if (mounted) setState(() => _isBusy = false);
  }

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return SliverInfiniteList(
      itemCount: _posts.length,
      isLoading: _isBusy,
      hasReachedMax: _postCount != null && _posts.length >= _postCount!,
      onFetchData: _fetchPosts,
      itemBuilder: (context, idx) {
        return GestureDetector(
          child: PostItem(data: _posts[idx]),
          onTap: () {
            GoRouter.of(context).pushNamed(
              'postDetail',
              pathParameters: {'slug': _posts[idx].id.toString()},
              extra: _posts[idx],
            );
          },
        );
      },
      separatorBuilder: (context, index) => const Divider(height: 1),
    );
  }
}

class PostCommentListPopup extends StatelessWidget {
  final int postId;
  final int commentCount;
  const PostCommentListPopup({
    super.key,
    required this.postId,
    this.commentCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Symbols.comment, size: 24),
            const Gap(16),
            Text('postCommentsDetailed')
                .plural(commentCount)
                .textStyle(Theme.of(context).textTheme.titleLarge!),
          ],
        ).padding(horizontal: 20, top: 16, bottom: 12),
        Expanded(
          child: CustomScrollView(
            slivers: [
              PostCommentSliverList(parentPostId: postId),
            ],
          ),
        ),
      ],
    );
  }
}
