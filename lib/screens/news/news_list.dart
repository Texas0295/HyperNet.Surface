import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:surface/providers/sn_network.dart';
import 'package:surface/types/news.dart';
import 'package:surface/widgets/app_bar_leading.dart';
import 'package:surface/widgets/dialog.dart';
import 'package:surface/widgets/navigation/app_scaffold.dart';
import 'package:surface/widgets/universal_image.dart';
import 'package:very_good_infinite_list/very_good_infinite_list.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<SnNewsSource>? _sources;

  @override
  initState() {
    super.initState();
    _fetchSources();
  }

  Future<void> _fetchSources() async {
    try {
      final sn = context.read<SnNetworkProvider>();
      final resp = await sn.client.get('/cgi/re/well-known/sources');
      _sources = List<SnNewsSource>.from(
        resp.data?.map((e) => SnNewsSource.fromJson(e)) ?? [],
      );
    } catch (err) {
      if (!mounted) return;
      context.showErrorDialog(err);
    } finally {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_sources == null) {
      return AppScaffold(
        appBar: AppBar(
          leading: AutoAppBarLeading(),
          title: Text('screenNews').tr(),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return DefaultTabController(
      length: _sources!.length + 1,
      child: AppScaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  leading: AutoAppBarLeading(),
                  title: Text('screenNews').tr(),
                  bottom: TabBar(
                    isScrollable: true,
                    tabs: [
                      Tab(child: Text('newsAllSources'.tr())),
                      for (final source in _sources!) Tab(child: Text(source.label)),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              _NewsArticleListWidget(),
              for (final source in _sources!) _NewsArticleListWidget(source: source.id),
            ],
          ),
        ),
      ),
    );
  }
}

class _NewsArticleListWidget extends StatefulWidget {
  final String? source;

  const _NewsArticleListWidget({this.source});

  @override
  State<_NewsArticleListWidget> createState() => _NewsArticleListWidgetState();
}

class _NewsArticleListWidgetState extends State<_NewsArticleListWidget> {
  bool _isBusy = false;

  int? _totalCount;
  final List<SnNewsArticle> _articles = List.empty(growable: true);

  Future<void> _fetchArticles() async {
    setState(() => _isBusy = true);

    try {
      final sn = context.read<SnNetworkProvider>();
      final resp = await sn.client.get('/cgi/re/news', queryParameters: {
        'take': 10,
        'offset': _articles.length,
        if (widget.source != null) 'source': widget.source,
      });
      _totalCount = resp.data['count'];
      _articles.addAll(List<SnNewsArticle>.from(
        resp.data['data']?.map((e) => SnNewsArticle.fromJson(e)) ?? [],
      ));
    } catch (err) {
      if (!mounted) return;
      context.showErrorDialog(err);
    } finally {
      setState(() => _isBusy = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchArticles();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: RefreshIndicator(
        onRefresh: _fetchArticles,
        child: InfiniteList(
          isLoading: _isBusy,
          itemCount: _articles.length,
          hasReachedMax: _totalCount != null && _articles.length >= _totalCount!,
          onFetchData: () {
            _fetchArticles();
          },
          itemBuilder: (context, index) {
            final article = _articles[index];

            final baseUri = Uri.parse(article.url);
            final baseUrl = '${baseUri.scheme}://${baseUri.host}';

            return Card(
              child: InkWell(
                radius: 8,
                onTap: () {
                  GoRouter.of(context).pushNamed(
                    'newsDetail',
                    pathParameters: {'hash': article.hash},
                  );
                },
                child: Column(
                  children: [
                    if (article.thumbnail.isNotEmpty && !article.thumbnail.endsWith('.svg'))
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: AutoResizeUniversalImage('$baseUrl/${article.thumbnail}'),
                        ),
                      ),
                    Text(article.title).textStyle(Theme.of(context).textTheme.titleLarge!),
                    Text(article.description).textStyle(Theme.of(context).textTheme.bodyMedium!),
                    const Gap(8),
                    Text(article.source).textStyle(Theme.of(context).textTheme.bodySmall!),
                  ],
                ).padding(all: 8),
              ),
            );
          },
        ),
      ),
    );
  }
}
