import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:surface/providers/post.dart';
import 'package:surface/providers/sn_network.dart';
import 'package:surface/providers/user_directory.dart';
import 'package:surface/types/account.dart';
import 'package:surface/types/post.dart';
import 'package:surface/widgets/account/account_image.dart';
import 'package:surface/widgets/dialog.dart';
import 'package:surface/widgets/post/post_item.dart';
import 'package:surface/widgets/universal_image.dart';
import 'package:very_good_infinite_list/very_good_infinite_list.dart';

class PostPublisherScreen extends StatefulWidget {
  final String name;
  const PostPublisherScreen({super.key, required this.name});

  @override
  State<PostPublisherScreen> createState() => _PostPublisherScreenState();
}

class _PostPublisherScreenState extends State<PostPublisherScreen> {
  late final ScrollController _scrollController = ScrollController();

  SnPublisher? _publisher;
  SnAccount? _account;

  Future<void> _fetchPublisher() async {
    try {
      final sn = context.read<SnNetworkProvider>();
      final ud = context.read<UserDirectoryProvider>();
      final resp = await sn.client.get('/cgi/co/publishers/${widget.name}');
      if (!mounted) return;
      _publisher = SnPublisher.fromJson(resp.data);
      _account = await ud.getAccount(_publisher?.accountId);
    } catch (err) {
      if (!mounted) return;
      context.showErrorDialog(err).then((_) {
        if (mounted) Navigator.pop(context);
      });
    } finally {
      setState(() {});
    }
  }

  double _appBarBlur = 0.0;

  late final _appBarWidth = MediaQuery.of(context).size.width;
  late final _appBarHeight =
      (_appBarWidth * kBannerAspectRatio).roundToDouble();

  void _updateAppBarBlur() {
    if (_scrollController.offset > _appBarHeight) return;
    setState(() {
      _appBarBlur =
          (_scrollController.offset / _appBarHeight * 10).clamp(0.0, 10.0);
    });
  }

  bool _isBusy = false;

  int? _postCount;
  final List<SnPost> _posts = List.empty(growable: true);

  Future<void> _fetchPosts() async {
    if (_isBusy) return;
    _isBusy = true;
    try {
      final pt = context.read<SnPostContentProvider>();
      final result = await pt.listPosts(
        offset: _posts.length,
        author: widget.name,
      );
      _postCount = result.$2;
      _posts.addAll(result.$1);
    } catch (err) {
      if (!mounted) return;
      context.showErrorDialog(err);
    } finally {
      _isBusy = false;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchPublisher().then((_) {
      _fetchPosts();
    });
    _scrollController.addListener(_updateAppBarBlur);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateAppBarBlur);
    _scrollController.dispose();
    super.dispose();
  }

  static const kBannerAspectRatio = 7 / 16;

  @override
  Widget build(BuildContext context) {
    final imageHeight = _appBarHeight + kToolbarHeight + 8;

    const labelShadows = <Shadow>[
      Shadow(
        offset: Offset(1, 1),
        blurRadius: 5.0,
        color: Color.fromARGB(255, 0, 0, 0),
      ),
    ];

    final sn = context.read<SnNetworkProvider>();

    // TODO fix loading on different type
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: MultiSliver(
                  children: [
                    SliverAppBar(
                      expandedHeight: _appBarHeight,
                      title: _publisher == null
                          ? Text('loading').tr()
                          : RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(children: [
                                TextSpan(
                                  text: _publisher!.nick,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        color: Colors.white,
                                        shadows: labelShadows,
                                      ),
                                ),
                                const TextSpan(text: '\n'),
                                TextSpan(
                                  text: '@${_publisher!.name}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: Colors.white,
                                        shadows: labelShadows,
                                      ),
                                ),
                              ]),
                            ),
                      pinned: true,
                      flexibleSpace: _publisher != null
                          ? Stack(
                              fit: StackFit.expand,
                              children: [
                                UniversalImage(
                                  sn.getAttachmentUrl(_publisher!.banner),
                                  fit: BoxFit.cover,
                                  height: imageHeight,
                                  width: _appBarWidth,
                                  cacheHeight: imageHeight,
                                  cacheWidth: _appBarWidth,
                                ),
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  right: 0,
                                  height:
                                      56 + MediaQuery.of(context).padding.top,
                                  child: ClipRect(
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                        sigmaX: _appBarBlur,
                                        sigmaY: _appBarBlur,
                                      ),
                                      child: Container(
                                        color: Colors.black.withOpacity(
                                          clampDouble(
                                              _appBarBlur * 0.1, 0, 0.5),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : null,
                    ),
                    if (_publisher != null)
                      SliverToBoxAdapter(
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 640),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  AccountImage(
                                    content: _publisher!.avatar,
                                    radius: 28,
                                  ),
                                  const Gap(16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _publisher!.nick,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ).bold(),
                                        Text('@${_publisher!.name}')
                                            .fontSize(13),
                                      ],
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                        elevation: WidgetStatePropertyAll(0)),
                                    onPressed: () {},
                                    child: Text('subscribe').tr(),
                                  ),
                                ],
                              ).padding(right: 8),
                              const Gap(12),
                              Text(_publisher!.description)
                                  .padding(horizontal: 8),
                              const Gap(12),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Symbols.calendar_add_on),
                                      const Gap(8),
                                      Text('publisherJoinedAt').tr(args: [
                                        DateFormat('y/M/d')
                                            .format(_publisher!.createdAt)
                                      ]),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Symbols.trending_up),
                                      const Gap(8),
                                      Text('publisherSocialPointTotal').plural(
                                        _publisher!.totalUpvote -
                                            _publisher!.totalDownvote,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Symbols.tools_wrench),
                                      const Gap(8),
                                      InkWell(
                                        child: Text('publisherRunBy').tr(args: [
                                          '@${_account?.name ?? 'unknown'}',
                                        ]),
                                        onTap: () {},
                                      ),
                                      const Gap(8),
                                      AccountImage(
                                          content: _account?.avatar, radius: 8),
                                    ],
                                  ),
                                ],
                              ).padding(horizontal: 8),
                            ],
                          ).padding(all: 16),
                        ).center(),
                      ),
                    SliverToBoxAdapter(child: const Divider(height: 1)),
                    TabBar(
                      tabs: [
                        Tab(
                          icon: Icon(
                            Symbols.pages,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        Tab(
                          icon: Icon(
                            Symbols.sticky_note_2,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        Tab(
                          icon: Icon(
                            Symbols.article,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                    SliverToBoxAdapter(child: const Divider(height: 1)),
                    Gap(MediaQuery.of(context).padding.top),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              InfiniteList(
                itemCount: _posts.length,
                isLoading: _isBusy,
                hasReachedMax:
                    _postCount != null && _posts.length >= _postCount!,
                onFetchData: _fetchPosts,
                itemBuilder: (context, idx) {
                  return GestureDetector(
                    child: PostItem(
                      data: _posts[idx],
                      maxWidth: 640,
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
              ),
              InfiniteList(
                itemCount: _posts.where((e) => e.type == 'story').length,
                isLoading: _isBusy,
                hasReachedMax:
                    _postCount != null && _posts.length >= _postCount!,
                onFetchData: _fetchPosts,
                itemBuilder: (context, idx) {
                  return GestureDetector(
                    child: PostItem(
                      data:
                          _posts.where((e) => e.type == 'story').elementAt(idx),
                      maxWidth: 640,
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
              ),
              InfiniteList(
                itemCount: _posts.where((e) => e.type == 'article').length,
                isLoading: _isBusy,
                hasReachedMax:
                    _postCount != null && _posts.length >= _postCount!,
                onFetchData: _fetchPosts,
                itemBuilder: (context, idx) {
                  return GestureDetector(
                    child: PostItem(
                      data: _posts
                          .where((e) => e.type == 'article')
                          .elementAt(idx),
                      maxWidth: 640,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
