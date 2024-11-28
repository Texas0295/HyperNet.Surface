import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:surface/providers/post.dart';
import 'package:surface/providers/userinfo.dart';
import 'package:surface/types/post.dart';
import 'package:surface/widgets/post/post_item.dart';
import 'package:surface/widgets/post/post_mini_editor.dart';
import 'package:very_good_infinite_list/very_good_infinite_list.dart';

class PostCommentSliverList extends StatefulWidget {
  final int parentPostId;
  final double? maxWidth;
  const PostCommentSliverList({
    super.key,
    required this.parentPostId,
    this.maxWidth,
  });

  @override
  State<PostCommentSliverList> createState() => PostCommentSliverListState();
}

class PostCommentSliverListState extends State<PostCommentSliverList> {
  bool _isBusy = true;

  final List<SnPost> _posts = List.empty(growable: true);
  int? _postCount;

  Future<void> _fetchPosts() async {
    if (_postCount != null && _posts.length >= _postCount!) return;

    setState(() => _isBusy = true);

    final pt = context.read<SnPostContentProvider>();
    final result = await pt.listPostReplies(widget.parentPostId);
    final List<SnPost> out = result.$1;

    if (!mounted) return;

    _postCount = result.$2;
    _posts.addAll(out);

    if (mounted) setState(() => _isBusy = false);
  }

  Future<void> refresh() async {
    _posts.clear();
    _fetchPosts();
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
          child: PostItem(
            data: _posts[idx],
            maxWidth: widget.maxWidth,
            onChanged: (data) {
              setState(() => _posts[idx] = data);
            },
            onDeleted: () {
              _posts.clear();
              _fetchPosts();
            },
          ),
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

class PostCommentListPopup extends StatefulWidget {
  final int postId;
  final int commentCount;
  const PostCommentListPopup({
    super.key,
    required this.postId,
    this.commentCount = 0,
  });

  @override
  State<PostCommentListPopup> createState() => _PostCommentListPopupState();
}

class _PostCommentListPopupState extends State<PostCommentListPopup> {
  final GlobalKey<PostCommentSliverListState> _childListKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final ua = context.watch<UserProvider>();
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Symbols.comment, size: 24),
            const Gap(16),
            Text('postCommentsDetailed')
                .plural(widget.commentCount)
                .textStyle(Theme.of(context).textTheme.titleLarge!),
          ],
        ).padding(horizontal: 20, top: 16, bottom: 12),
        Expanded(
          child: CustomScrollView(
            slivers: [
              if (ua.isAuthorized)
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
                      postReplyId: widget.postId,
                      onPost: () {
                        _childListKey.currentState!.refresh();
                      },
                    ),
                  ),
                ),
              PostCommentSliverList(
                key: _childListKey,
                parentPostId: widget.postId,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
