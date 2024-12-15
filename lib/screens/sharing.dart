import 'dart:async';
import 'dart:developer';

import 'package:cross_file/cross_file.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:surface/controllers/post_write_controller.dart';
import 'package:surface/screens/post/post_editor.dart';
import 'package:surface/widgets/dialog.dart';

class AppSharingListener extends StatefulWidget {
  final Widget child;

  const AppSharingListener({super.key, required this.child});

  @override
  State<AppSharingListener> createState() => _AppSharingListenerState();
}

class _AppSharingListenerState extends State<AppSharingListener> {
  late StreamSubscription _shareIntentSubscription;

  void _gotoPost(Iterable<SharedMediaFile> value) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('shareIntent').tr(),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('shareIntentDescription').tr(),
              const Gap(8),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      leading: Icon(Icons.post_add),
                      trailing: const Icon(Icons.chevron_right),
                      title: Text('shareIntentPostStory').tr(),
                      onTap: () {
                        GoRouter.of(context).pushNamed(
                          'postEditor',
                          pathParameters: {
                            'mode': 'stories',
                          },
                          extra: PostEditorExtraProps(
                            text: value
                                .where((e) => [SharedMediaType.text, SharedMediaType.url].contains(e.type))
                                .map((e) => e.path).join('\n'),
                            attachments: value
                                .where((e) => [SharedMediaType.video, SharedMediaType.file, SharedMediaType.image].contains(e.type))
                                .map((e) => PostWriteMedia.fromFile(XFile(e.path))).toList(),
                          ),
                        );
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('dialogDismiss').tr(),
            )
          ],
        ),
      );
    });
  }

  void _initialize() async {
    _shareIntentSubscription = ReceiveSharingIntent.instance.getMediaStream().listen((value) {
      if (value.isEmpty) return;
      if (mounted) {
        _gotoPost(value);
      }
    }, onError: (err) {
      log("[ShareIntent] Unable to subscribe: $err");
    });
  }

  void _initialHandle() {
    ReceiveSharingIntent.instance.getInitialMedia().then((value) {
      if (value.isEmpty) return;
      if (mounted) {
        _gotoPost(value);
      }
      ReceiveSharingIntent.instance.reset();
    });
  }

  @override
  void initState() {
    super.initState();
    _initialize();
    _initialHandle();
  }

  @override
  void dispose() {
    _shareIntentSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
