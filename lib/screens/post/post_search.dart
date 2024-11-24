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

class PostSearchScreen extends StatefulWidget {
  const PostSearchScreen({super.key});

  @override
  State<PostSearchScreen> createState() => _PostSearchScreenState();
}

class _PostSearchScreenState extends State<PostSearchScreen> {
  bool _isBusy = false;

  final List<SnPost> _posts = List.empty(growable: true);
  int? _postCount;

  String _searchTerm = '';
  Duration? _lastTook;

  Future<void> _fetchPosts() async {
    if (_searchTerm.isEmpty) return;
    if (_postCount != null && _posts.length >= _postCount!) return;

    setState(() => _isBusy = true);

    final stopwatch = Stopwatch()..start();

    final sn = context.read<SnNetworkProvider>();
    final resp = await sn.client.get('/cgi/co/posts/search', queryParameters: {
      'take': 10,
      'offset': _posts.length,
      'probe': _searchTerm,
    });
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
                (ele) =>
                    out[i].body['attachments']?.contains(ele?.rid) ?? false,
              )
              .toList(),
        ),
      );
    }

    stopwatch.stop();

    _lastTook = stopwatch.elapsed;
    _postCount = resp.data['count'];
    _posts.addAll(out);

    if (mounted) setState(() => _isBusy = false);
  }

  void _showAdvancedSearchTune() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        children: [],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const labelShadows = <Shadow>[
      Shadow(
        offset: Offset(1, 1),
        blurRadius: 8.0,
        color: Color.fromARGB(255, 0, 0, 0),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('screenPostSearch').tr(),
        actions: [
          IconButton(
            icon: const Icon(Symbols.tune),
            onPressed: _showAdvancedSearchTune,
          ),
          const Gap(8),
        ],
      ),
      body: Stack(
        children: [
          InfiniteList(
            padding: const EdgeInsets.only(top: 100),
            itemCount: _posts.length,
            isLoading: _isBusy,
            hasReachedMax: _postCount != null && _posts.length >= _postCount!,
            onFetchData: () {
              _fetchPosts();
            },
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
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Column(
              children: [
                SearchBar(
                  elevation: const WidgetStatePropertyAll(1),
                  leading: const Icon(Symbols.search),
                  padding: const WidgetStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 24),
                  ),
                  onChanged: (value) {
                    _searchTerm = value;
                  },
                  onSubmitted: (value) {
                    setState(() => _posts.clear());

                    _searchTerm = value;
                    _fetchPosts();
                  },
                ),
                if (_lastTook != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Symbols.summarize,
                        color: Colors.white,
                        shadows: labelShadows,
                        size: 16,
                      ),
                      const Gap(4),
                      Text(
                        'postSearchResult'.plural(_postCount ?? 0),
                        style: TextStyle(
                          color: Colors.white,
                          shadows: labelShadows,
                          fontSize: 13,
                        ),
                      ),
                      const Gap(8),
                      Icon(
                        Symbols.pace,
                        color: Colors.white,
                        shadows: labelShadows,
                        size: 16,
                      ),
                      const Gap(4),
                      Text(
                        'postSearchTook'.tr(args: [
                          '${(_lastTook!.inMilliseconds / 1000).toStringAsFixed(3)}s',
                        ]),
                        style: TextStyle(
                          color: Colors.white,
                          shadows: labelShadows,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ).padding(vertical: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
