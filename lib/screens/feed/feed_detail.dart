import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:html/parser.dart';
import 'package:html2md/html2md.dart' as html2md;
import 'package:provider/provider.dart';
import 'package:relative_time/relative_time.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:surface/providers/sn_network.dart';
import 'package:surface/types/news.dart';
import 'package:surface/widgets/dialog.dart';
import 'package:surface/widgets/markdown_content.dart';
import 'package:surface/widgets/navigation/app_scaffold.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ReaderPageScreen extends StatefulWidget {
  final String id;

  const ReaderPageScreen({super.key, required this.id});

  @override
  State<ReaderPageScreen> createState() => _ReaderPageScreenState();
}

class _ReaderPageScreenState extends State<ReaderPageScreen> {
  SnSubscriptionItem? _article;

  Future<void> _fetchArticle() async {
    try {
      final sn = context.read<SnNetworkProvider>();
      final resp = await sn.client.get('/cgi/re/subscriptions/${widget.id}');
      _article = SnSubscriptionItem.fromJson(resp.data);
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
            content: Text(_isReadingFromReader
                ? 'newsReadingFromReader'.tr()
                : 'newsReadingFromOriginal'.tr()),
            actions: [
              TextButton(
                child: Text('newsReadingProviderSwap').tr(),
                onPressed: () {
                  setState(() => _isReadingFromReader = !_isReadingFromReader);
                },
              ),
            ],
          ),
          if (_article != null && _isReadingFromReader)
            Expanded(
              child: Container(
                constraints: BoxConstraints(maxWidth: 640),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8,
                    children: [
                      Text(_article!.title,
                          style: Theme.of(context).textTheme.titleLarge),
                      Builder(builder: (context) {
                        final htmlDescription = parse(_article!.description);
                        return Text(
                          htmlDescription.children
                              .map((ele) => ele.text.trim())
                              .join(),
                          style: Theme.of(context).textTheme.bodyMedium,
                        );
                      }),
                      Builder(builder: (context) {
                        final date =
                            _article!.publishedAt ?? _article!.createdAt;
                        return Row(
                          spacing: 2,
                          children: [
                            Text(DateFormat().format(date)).textStyle(
                                Theme.of(context).textTheme.bodySmall!),
                            Text(' · ')
                                .textStyle(
                                    Theme.of(context).textTheme.bodySmall!)
                                .bold(),
                            Text(RelativeTime(context).format(date)).textStyle(
                                Theme.of(context).textTheme.bodySmall!),
                          ],
                        ).opacity(0.75);
                      }),
                      Text('newsDisclaimer')
                          .tr()
                          .textStyle(Theme.of(context).textTheme.bodySmall!)
                          .opacity(0.75),
                      const Divider(),
                      MarkdownTextContent(
                        textScaler: TextScaler.linear(1.2),
                        content: html2md.convert(_article!.content),
                      ),
                      const Divider(),
                      InkWell(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Reference from original website',
                              style: TextStyle(
                                  decoration: TextDecoration.underline),
                            ),
                            const Gap(4),
                            Icon(Icons.launch, size: 16),
                          ],
                        ).opacity(0.85),
                        onTap: () {
                          launchUrlString(_article!.url);
                        },
                      ),
                      Gap(MediaQuery.of(context).padding.bottom),
                    ],
                  ).padding(horizontal: 12, vertical: 16),
                ),
              ).center(),
            )
          else if (_article != null)
            Expanded(
              child: InAppWebView(
                key: GlobalKey(),
                initialUrlRequest: URLRequest(url: WebUri(_article!.url)),
              ),
            ),
        ],
      ),
    );
  }
}
