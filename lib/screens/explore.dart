import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surface/providers/sn_network.dart';
import 'package:surface/types/post.dart';
import 'package:surface/widgets/navigation/app_scaffold.dart';
import 'package:surface/widgets/post/post_item.dart';
import 'package:very_good_infinite_list/very_good_infinite_list.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  bool _isBusy = true;

  final List<SnPost> _posts = List.empty(growable: true);
  int? _postCount;

  void _fetchPosts() async {
    if (_postCount != null && _posts.length >= _postCount!) return;

    setState(() => _isBusy = true);

    final sn = context.read<SnNetworkProvider>();
    final resp = await sn.client.get('/cgi/co/posts', queryParameters: {
      'take': 10,
      'offset': _posts.length,
    });

    _postCount = resp.data['count'];
    _posts.addAll(
        resp.data['data']?.map((e) => SnPost.fromJson(e)).cast<SnPost>() ?? []);

    if (mounted) setState(() => _isBusy = false);
  }

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: Text('screenExplore').tr(),
      ),
      body: InfiniteList(
        itemCount: _posts.length,
        isLoading: _isBusy,
        hasReachedMax: _postCount != null && _posts.length >= _postCount!,
        onFetchData: _fetchPosts,
        itemBuilder: (context, idx) {
          return PostItem(data: _posts[idx]);
        },
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }
}
