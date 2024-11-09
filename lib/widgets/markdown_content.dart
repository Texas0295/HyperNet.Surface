import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markdown/markdown.dart' as markdown;
import 'package:styled_widget/styled_widget.dart';
import 'package:surface/widgets/universal_image.dart';
import 'package:syntax_highlight/syntax_highlight.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:path/path.dart';

class MarkdownTextContent extends StatefulWidget {
  final String content;
  final bool isSelectable;
  final bool isLargeText;
  final bool isAutoWarp;

  const MarkdownTextContent({
    super.key,
    required this.content,
    this.isSelectable = false,
    this.isLargeText = false,
    this.isAutoWarp = false,
  });

  @override
  State<MarkdownTextContent> createState() => _MarkdownTextContentState();
}

class _MarkdownTextContentState extends State<MarkdownTextContent> {
  Widget _buildContent(BuildContext context) {
    return Markdown(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      data: widget.content,
      padding: EdgeInsets.zero,
      styleSheet: MarkdownStyleSheet.fromTheme(
        Theme.of(context),
      ).copyWith(
          textScaler: TextScaler.linear(widget.isLargeText ? 1.1 : 1),
          blockquote: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          blockquoteDecoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHigh,
            borderRadius: const BorderRadius.all(Radius.circular(4)),
          ),
          horizontalRuleDecoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                width: 1.0,
                color: Theme.of(context).dividerColor,
              ),
            ),
          ),
          codeblockDecoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).dividerColor,
              width: 0.3,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
          )),
      builders: {
        'code': _MarkdownTextCodeElement(),
      },
      softLineBreak: true,
      extensionSet: markdown.ExtensionSet(
        <markdown.BlockSyntax>[
          markdown.CodeBlockSyntax(),
          ...markdown.ExtensionSet.commonMark.blockSyntaxes,
          ...markdown.ExtensionSet.gitHubFlavored.blockSyntaxes,
        ],
        <markdown.InlineSyntax>[
          if (widget.isAutoWarp) markdown.LineBreakSyntax(),
          _UserNameCardInlineSyntax(),
          markdown.AutolinkSyntax(),
          markdown.AutolinkExtensionSyntax(),
          markdown.CodeSyntax(),
          ...markdown.ExtensionSet.commonMark.inlineSyntaxes,
          ...markdown.ExtensionSet.gitHubFlavored.inlineSyntaxes
        ],
      ),
      onTapLink: (text, href, title) async {
        if (href == null) return;
        if (href.startsWith('solink://')) {
          // final segments = href.replaceFirst('solink://', '').split('/');
          return;
        }

        await launchUrlString(
          href,
          mode: LaunchMode.externalApplication,
        );
      },
      imageBuilder: (uri, title, alt) {
        var url = uri.toString();
        double? width, height;
        BoxFit? fit;
        if (url.startsWith('solink://')) {
          // final segments = url.replaceFirst('solink://', '').split('/');
          return const SizedBox.shrink();
        }
        return UniversalImage(
          url,
          width: width,
          height: height,
          fit: fit,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isSelectable) {
      return SelectionArea(child: _buildContent(context));
    }
    return _buildContent(context);
  }
}

class _UserNameCardInlineSyntax extends markdown.InlineSyntax {
  _UserNameCardInlineSyntax() : super(r'@[a-zA-Z0-9_]+');

  @override
  bool onMatch(markdown.InlineParser parser, Match match) {
    final alias = match[0]!;
    final anchor = markdown.Element.text('a', alias)
      ..attributes['href'] = Uri.encodeFull(
        'solink://users/${alias.substring(1)}',
      );
    parser.addNode(anchor);

    return true;
  }
}

class _MarkdownTextCodeElement extends MarkdownElementBuilder {
  @override
  Widget? visitElementAfter(
    markdown.Element element,
    TextStyle? preferredStyle,
  ) {
    var language = '';

    if (element.attributes['class'] != null) {
      String lg = element.attributes['class'] as String;
      language = lg.substring(9).trim();
    }
    return SizedBox(
      child: FutureBuilder(
        future: (() async {
          final docPath = '../../../';
          final highlightingPath =
              join(docPath, 'assets/highlighting', language);
          await Highlighter.initialize([highlightingPath]);
          return Highlighter(
            language: highlightingPath,
            theme: PlatformDispatcher.instance.platformBrightness ==
                    Brightness.light
                ? await HighlighterTheme.loadLightTheme()
                : await HighlighterTheme.loadDarkTheme(),
          );
        })(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final highlighter = snapshot.data!;
            return Text.rich(
              highlighter.highlight(element.textContent.trim()),
              style: GoogleFonts.robotoMono(),
            );
          }
          return Text(
            element.textContent.trim(),
            style: GoogleFonts.robotoMono(),
          );
        },
      ),
    ).padding(all: 8);
  }
}
