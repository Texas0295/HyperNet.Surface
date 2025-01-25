import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surface/providers/sn_network.dart';
import 'package:surface/types/news.dart';
import 'package:surface/widgets/dialog.dart';
import 'package:surface/widgets/navigation/app_scaffold.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class NewsDetailScreen extends StatefulWidget {
  final String hash;

  const NewsDetailScreen({super.key, required this.hash});

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  SnNewsArticle? _article;

  Future<void> _fetchArticle() async {
    try {
      final sn = context.read<SnNetworkProvider>();
      final resp = await sn.client.get('/cgi/re/news/${widget.hash}');
      _article = SnNewsArticle.fromJson(resp.data);
    } catch (err) {
      if (!mounted) return;
      context.showErrorDialog(err).then((_) {
        if (!mounted) return;
        Navigator.pop(context);
      });
    } finally {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchArticle();
  }

  bool _isReadingFromReader = true;

  String get _htmlContent => """
      <!DOCTYPE html>
      <html>
      <head>
        <style>
          body {
            background-color: #000000;
            color: #fff;
            font-family: Arial, sans-serif;
            padding: 20px;
          }
        </style>
      </head>
      <body>
        ${_article?.content ?? ''}
      </body>
      </html>
    """;

  InAppWebViewController? _webViewController;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        leading: const PageBackButton(),
        title: Text(_article?.title ?? 'loading'.tr()),
      ),
      body: Column(
        children: [
          MaterialBanner(
            dividerColor: Colors.transparent,
            leading: const Icon(Icons.info),
            content: Text(_isReadingFromReader ? 'newsReadingFromReader'.tr() : 'newsReadingFromOriginal'.tr()),
            actions: [
              TextButton(
                child: Text('newsReadingProviderSwap').tr(),
                onPressed: () {
                  setState(() => _isReadingFromReader = !_isReadingFromReader);
                  if (!_isReadingFromReader) {
                    _webViewController?.goTo(historyItem: WebHistoryItem(url: WebUri(_article!.url)));
                  } else {
                    _webViewController?.goBack();
                  }
                },
              ),
            ],
          ),
          Expanded(
            child: InAppWebView(
              key: Key('news-detail-webview-${widget.hash}-$_isReadingFromReader'),
              onWebViewCreated: (controller) {
                _webViewController = controller;
              },
              initialUrlRequest: URLRequest(url: WebUri(_article!.url)),
              onLoadStop: (controller, url) {
                print("Loaded: $url");
              },
              onLoadError: (controller, url, code, message) {
                print("Error loading $url: $message ($code)");
              },
            ),
          ),
        ],
      ),
    );
  }
}
