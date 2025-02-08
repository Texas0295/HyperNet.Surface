import 'package:animations/animations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:surface/providers/config.dart';
import 'package:surface/providers/post.dart';
import 'package:surface/providers/sn_network.dart';
import 'package:surface/screens/post/post_detail.dart';
import 'package:surface/types/post.dart';
import 'package:surface/widgets/app_bar_leading.dart';
import 'package:surface/widgets/dialog.dart';
import 'package:surface/widgets/navigation/app_scaffold.dart';
import 'package:surface/widgets/post/post_item.dart';
import 'package:very_good_infinite_list/very_good_infinite_list.dart';

const Map<String, IconData> kCategoryIcons = {
  'technology': Symbols.tools_wrench,
  'gaming': Symbols.gamepad,
  'life': Symbols.nightlife,
  'arts': Symbols.format_paint,
  'sports': Symbols.sports_soccer,
  'music': Symbols.music_note,
  'news': Symbols.newspaper,
  'knowledge': Symbols.library_books,
  'literature': Symbols.book,
  'funny': Symbols.attractions,
};

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final _fabKey = GlobalKey<ExpandableFabState>();

  bool _isBusy = true;

  final List<SnPost> _posts = List.empty(growable: true);
  final List<SnPostCategory> _categories = List.empty(growable: true);
  int? _postCount;

  String? _selectedCategory;

  Future<void> _fetchCategories() async {
    _categories.clear();
    try {
      final sn = context.read<SnNetworkProvider>();
      final resp = await sn.client.get('/cgi/co/categories?take=100');
      _categories.addAll(resp.data.map((e) => SnPostCategory.fromJson(e)).cast<SnPostCategory>() ?? []);
    } catch (err) {
      if (!mounted) return;
      context.showErrorDialog(err);
    }
  }

  Future<void> _fetchPosts() async {
    if (_postCount != null && _posts.length >= _postCount!) return;

    setState(() => _isBusy = true);

    final pt = context.read<SnPostContentProvider>();
    final result = await pt.listPosts(
      take: 10,
      offset: _posts.length,
      categories: _selectedCategory != null ? [_selectedCategory!] : null,
    );
    final out = result.$1;

    if (!mounted) return;

    _postCount = result.$2;
    _posts.addAll(out);

    if (mounted) setState(() => _isBusy = false);
  }

  Future<void> _refreshPosts() {
    _postCount = null;
    _posts.clear();
    return _fetchPosts();
  }

  @override
  void initState() {
    super.initState();
    _fetchPosts();
    _fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    final cfg = context.read<ConfigProvider>();

    return AppScaffold(
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        key: _fabKey,
        distance: 75,
        type: ExpandableFabType.up,
        childrenAnimation: ExpandableFabAnimation.none,
        overlayStyle: ExpandableFabOverlayStyle(
          color: Theme.of(context).colorScheme.surface.withAlpha((255 * 0.5).round()),
        ),
        openButtonBuilder: RotateFloatingActionButtonBuilder(
          child: const Icon(Symbols.add, size: 28),
          fabSize: ExpandableFabSize.regular,
          foregroundColor: Theme.of(context).floatingActionButtonTheme.foregroundColor,
          backgroundColor: Theme.of(context).floatingActionButtonTheme.backgroundColor,
          shape: const CircleBorder(),
        ),
        closeButtonBuilder: DefaultFloatingActionButtonBuilder(
          child: const Icon(Symbols.close, size: 28),
          fabSize: ExpandableFabSize.regular,
          foregroundColor: Theme.of(context).floatingActionButtonTheme.foregroundColor,
          backgroundColor: Theme.of(context).floatingActionButtonTheme.backgroundColor,
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
                      _refreshPosts();
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
                      _refreshPosts();
                    }
                  });
                  _fabKey.currentState!.toggle();
                },
                child: const Icon(Symbols.news),
              ),
            ],
          ),
          Row(
            children: [
              Text('writePostTypeQuestion').tr(),
              const Gap(20),
              FloatingActionButton(
                heroTag: null,
                tooltip: 'writePostTypeQuestion'.tr(),
                onPressed: () {
                  GoRouter.of(context).pushNamed('postEditor', pathParameters: {
                    'mode': 'questions',
                  }).then((value) {
                    if (value == true) {
                      _refreshPosts();
                    }
                  });
                  _fabKey.currentState!.toggle();
                },
                child: const Icon(Symbols.question_answer),
              ),
            ],
          ),
        ],
      ),
      body: RefreshIndicator(
        displacement: 40 + MediaQuery.of(context).padding.top,
        onRefresh: () => _refreshPosts(),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: AutoAppBarLeading(),
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
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(50),
                child: SizedBox(
                  height: 50,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: 8, right: 8, bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _categories.map((ele) {
                        return StyledWidget(ChoiceChip(
                          avatar: Icon(kCategoryIcons[ele.alias] ?? Symbols.question_mark),
                          label: Text(
                            'postCategory${ele.alias.capitalize()}'.trExists()
                                ? 'postCategory${ele.alias.capitalize()}'.tr()
                                : ele.name,
                          ),
                          selected: _selectedCategory == ele.alias,
                          onSelected: (value) {
                            _selectedCategory = value ? ele.alias : null;
                            _refreshPosts();
                          },
                        )).padding(horizontal: 4);
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
            const SliverGap(12),
            SliverInfiniteList(
              itemCount: _posts.length,
              isLoading: _isBusy,
              centerLoading: true,
              hasReachedMax: _postCount != null && _posts.length >= _postCount!,
              onFetchData: _fetchPosts,
              itemBuilder: (context, idx) {
                return Center(
                  child: OpenablePostItem(
                    data: _posts[idx],
                    maxWidth: 640,
                    onChanged: (data) {
                      setState(() => _posts[idx] = data);
                    },
                    onDeleted: () {
                      _refreshPosts();
                    },
                  ),
                );
              },
              separatorBuilder: (_, __) => const Gap(8),
            ),
          ],
        ),
      ),
    );
  }
}
