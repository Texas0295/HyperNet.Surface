import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import 'package:surface/providers/post.dart';
import 'package:surface/types/post.dart';
import 'package:surface/widgets/post/post_item.dart';
import 'package:very_good_infinite_list/very_good_infinite_list.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final _fabKey = GlobalKey<ExpandableFabState>();

  bool _isBusy = true;

  final List<SnPost> _posts = List.empty(growable: true);
  int? _postCount;

  Future<void> _fetchPosts() async {
    if (_postCount != null && _posts.length >= _postCount!) return;

    setState(() => _isBusy = true);

    final pt = context.read<SnPostContentProvider>();
    final result = await pt.listPosts(take: 10, offset: _posts.length);
    final out = result.$1;

    if (!mounted) return;

    _postCount = result.$2;
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
    return Scaffold(
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        key: _fabKey,
        distance: 75,
        type: ExpandableFabType.up,
        childrenAnimation: ExpandableFabAnimation.none,
        overlayStyle: ExpandableFabOverlayStyle(
          color: Theme.of(context)
              .colorScheme
              .surface
              .withAlpha((255 * 0.5).round()),
        ),
        openButtonBuilder: RotateFloatingActionButtonBuilder(
          child: const Icon(Symbols.add, size: 28),
          fabSize: ExpandableFabSize.regular,
          foregroundColor:
              Theme.of(context).floatingActionButtonTheme.foregroundColor,
          backgroundColor:
              Theme.of(context).floatingActionButtonTheme.backgroundColor,
          shape: const CircleBorder(),
        ),
        closeButtonBuilder: DefaultFloatingActionButtonBuilder(
          child: const Icon(Symbols.close, size: 28),
          fabSize: ExpandableFabSize.regular,
          foregroundColor:
              Theme.of(context).floatingActionButtonTheme.foregroundColor,
          backgroundColor:
              Theme.of(context).floatingActionButtonTheme.backgroundColor,
          shape: const CircleBorder(),
        ),
        children: [
          Row(
            children: [
              Text('writePostTypeStory').tr(),
              const Gap(20),
              FloatingActionButton(
                heroTag: null,
                tooltip: 'writePostTypeStory'.tr(),
                onPressed: () {
                  GoRouter.of(context).pushNamed('postEditor', pathParameters: {
                    'mode': 'stories',
                  }).then((value) {
                    if (value == true) {
                      _posts.clear();
                      _fetchPosts();
                    }
                  });
                  _fabKey.currentState!.toggle();
                },
                child: const Icon(Symbols.post_rounded),
              ),
            ],
          ),
          Row(
            children: [
              Text('writePostTypeArticle').tr(),
              const Gap(20),
              FloatingActionButton(
                heroTag: null,
                tooltip: 'writePostTypeArticle'.tr(),
                onPressed: () {
                  GoRouter.of(context).pushNamed('postEditor', pathParameters: {
                    'mode': 'articles',
                  }).then((value) {
                    if (value == true) {
                      _posts.clear();
                      _fetchPosts();
                    }
                  });
                  _fabKey.currentState!.toggle();
                },
                child: const Icon(Symbols.news),
              ),
            ],
          ),
        ],
      ),
      body: RefreshIndicator(
        displacement: 40 + MediaQuery.of(context).padding.top,
        onRefresh: () {
          _posts.clear();
          return _fetchPosts();
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text('screenExplore').tr(),
              floating: true,
              snap: true,
              actions: [
                IconButton(
                  icon: const Icon(Symbols.search),
                  onPressed: () {
                    GoRouter.of(context).pushNamed('postSearch');
                  },
                ),
                const Gap(8),
              ],
            ),
            SliverInfiniteList(
              itemCount: _posts.length,
              isLoading: _isBusy,
              centerLoading: true,
              hasReachedMax: _postCount != null && _posts.length >= _postCount!,
              onFetchData: _fetchPosts,
              itemBuilder: (context, idx) {
                return GestureDetector(
                  child: PostItem(
                    data: _posts[idx],
                    maxWidth: 640,
                    onChanged: (data) {
                      setState(() => _posts[idx] = data);
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
            ),
          ],
        ),
      ),
    );
  }
}
