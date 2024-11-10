import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:surface/providers/sn_attachment.dart';
import 'package:surface/providers/sn_network.dart';
import 'package:surface/types/attachment.dart';
import 'package:surface/types/post.dart';
import 'package:surface/widgets/account/account_image.dart';
import 'package:surface/widgets/navigation/app_scaffold.dart';
import 'package:surface/widgets/post/post_media_pending_list.dart';
import 'package:surface/widgets/post/post_meta_editor.dart';
import 'package:surface/widgets/dialog.dart';
import 'package:provider/provider.dart';

class PostEditorScreen extends StatefulWidget {
  final String mode;
  const PostEditorScreen({super.key, required this.mode});

  @override
  State<PostEditorScreen> createState() => _PostEditorScreenState();
}

class _PostEditorScreenState extends State<PostEditorScreen> {
  static const Map<String, String> _kTitleMap = {
    'stories': 'writePostTypeStory',
    'articles': 'writePostTypeArticle',
  };

  bool _isBusy = false;

  SnPublisher? _publisher;
  List<SnPublisher>? _publishers;

  final List<XFile> _selectedMedia = List.empty(growable: true);
  final List<SnAttachment> _attachments = List.empty(growable: true);

  void _fetchPublishers() async {
    final sn = context.read<SnNetworkProvider>();
    final resp = await sn.client.get('/cgi/co/publishers');
    _publishers = List<SnPublisher>.from(
      resp.data?.map((e) => SnPublisher.fromJson(e)) ?? [],
    );
    setState(() {
      _publisher = _publishers?.first;
    });
  }

  String? _title;
  String? _description;

  final TextEditingController _contentController = TextEditingController();

  double? _progress;

  static const kAttachmentProgressWeight = 0.9;
  static const kPostingProgressWeight = 0.1;

  void _performAction() async {
    if (_isBusy || _publisher == null) return;

    final sn = context.read<SnNetworkProvider>();
    final attach = context.read<SnAttachmentProvider>();

    setState(() {
      _progress = 0;
      _isBusy = true;
    });

    // Uploading attachments
    try {
      for (int i = 0; i < _selectedMedia.length; i++) {
        final media = _selectedMedia[i];
        final place = await attach.chunkedUploadInitialize(
          await media.length(),
          media.name,
          'interactive',
          null,
        );

        final item = await attach.chunkedUploadParts(
          media,
          place.$1,
          place.$2,
          onProgress: (progress) {
            // Calculate overall progress for attachments
            setState(() {
              _progress = ((i + progress) / _selectedMedia.length) *
                  kAttachmentProgressWeight;
            });
          },
        );

        _attachments.add(item);
      }
    } catch (err) {
      if (!mounted) return;
      context.showErrorDialog(err);
      setState(() => _isBusy = false);
      return;
    }

    setState(() => _progress = kAttachmentProgressWeight);

    // Posting the content
    try {
      final baseProgressVal = _progress!;
      await sn.client.post('/cgi/co/${widget.mode}', data: {
        'publisher': _publisher!.id,
        'content': _contentController.value.text,
        'title': _title,
        'description': _description,
        'attachments': _attachments.map((e) => e.rid).toList(),
      }, onSendProgress: (count, total) {
        setState(() {
          _progress =
              baseProgressVal + (count / total) * (kPostingProgressWeight / 2);
        });
      }, onReceiveProgress: (count, total) {
        setState(() {
          _progress = baseProgressVal +
              (kPostingProgressWeight / 2) +
              (count / total) * (kPostingProgressWeight / 2);
        });
      });
      if (!mounted) return;
      Navigator.pop(context, true);
    } catch (err) {
      if (!mounted) return;
      context.showErrorDialog(err);
    } finally {
      setState(() => _isBusy = false);
    }
  }

  void _updateMeta() {
    showModalBottomSheet<PostMetaResult?>(
      context: context,
      builder: (context) => PostMetaEditor(
        initialTitle: _title,
        initialDescription: _description,
      ),
      useRootNavigator: true,
    ).then((value) {
      if (value is PostMetaResult) {
        _title = value.title;
        _description = value.description;
        setState(() {});
      }
    });
  }

  final _imagePicker = ImagePicker();

  void _selectMedia() async {
    final result = await _imagePicker.pickMultipleMedia();
    if (result.isEmpty) return;
    _selectedMedia.addAll(result);
    setState(() {});
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (!_kTitleMap.keys.contains(widget.mode)) {
      context.showErrorDialog('Unknown post type');
      Navigator.pop(context);
    }
    _fetchPublishers();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        flexibleSpace: Column(
          children: [
            Text(_title ?? 'Untitled')
                .textStyle(Theme.of(context).textTheme.titleLarge!)
                .textColor(Colors.white),
            Text(_kTitleMap[widget.mode]!)
                .tr()
                .textColor(Colors.white.withAlpha((255 * 0.9).round())),
          ],
        ).padding(top: MediaQuery.of(context).padding.top),
        actions: [
          IconButton(
            icon: const Icon(Symbols.tune),
            onPressed: _isBusy ? null : _updateMeta,
          ),
        ],
      ),
      body: Column(
        children: [
          DropdownButtonHideUnderline(
            child: DropdownButton2<SnPublisher>(
              isExpanded: true,
              hint: Text(
                'fieldPostPublisher',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).hintColor,
                ),
              ).tr(),
              items: <DropdownMenuItem<SnPublisher>>[
                ...(_publishers?.map(
                      (item) => DropdownMenuItem<SnPublisher>(
                        value: item,
                        child: Row(
                          children: [
                            AccountImage(content: item.avatar, radius: 16),
                            const Gap(8),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.nick).textStyle(
                                      Theme.of(context).textTheme.bodyMedium!),
                                  Text('@${item.name}')
                                      .textStyle(Theme.of(context)
                                          .textTheme
                                          .bodySmall!)
                                      .fontSize(12),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ) ??
                    []),
                DropdownMenuItem<SnPublisher>(
                  value: null,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.transparent,
                        foregroundColor:
                            Theme.of(context).colorScheme.onSurface,
                        child: const Icon(Symbols.add),
                      ),
                      const Gap(8),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('publishersNew').tr().textStyle(
                                Theme.of(context).textTheme.bodyMedium!),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              value: _publisher,
              onChanged: (SnPublisher? value) {
                if (value == null) {
                  GoRouter.of(context)
                      .pushNamed('accountPublisherNew')
                      .then((value) {
                    if (value == true) {
                      _publisher = null;
                      _publishers = null;
                      _fetchPublishers();
                    }
                  });
                } else {
                  setState(() {
                    _publisher = value;
                  });
                }
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.only(right: 16),
                height: 48,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 48,
              ),
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: [
                  TextField(
                    controller: _contentController,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'fieldPostContent'.tr(),
                      hintStyle: TextStyle(fontSize: 14),
                      isCollapsed: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      border: InputBorder.none,
                    ),
                    onTapOutside: (_) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                  )
                ],
              ),
            ),
          ),
          if (_selectedMedia.isNotEmpty)
            PostMediaPendingList(
              data: _selectedMedia,
              onRemove: (idx) {
                setState(() {
                  _selectedMedia.removeAt(idx);
                });
              },
            ).padding(bottom: 8),
          Material(
            elevation: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_isBusy && _progress != null)
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: 1),
                    duration: Duration(milliseconds: 300),
                    builder: (context, value, _) =>
                        LinearProgressIndicator(value: value, minHeight: 2),
                  )
                else if (_isBusy)
                  const LinearProgressIndicator(value: null, minHeight: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ScrollConfiguration(
                        behavior: _PostEditorActionScrollBehavior(),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: _isBusy ? null : _selectMedia,
                                icon: Icon(
                                  Symbols.add_photo_alternate,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: (_isBusy || _publisher == null)
                          ? null
                          : _performAction,
                      icon: const Icon(Symbols.send),
                      label: Text('postPublish').tr(),
                    ),
                  ],
                ).padding(horizontal: 16),
              ],
            ).padding(
              bottom: MediaQuery.of(context).padding.bottom,
              top: 4,
            ),
          ),
        ],
      ),
    );
  }
}

class _PostEditorActionScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
