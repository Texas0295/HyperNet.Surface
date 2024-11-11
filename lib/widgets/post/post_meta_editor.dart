import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:surface/controllers/post_write_controller.dart';

class PostMetaEditor extends StatelessWidget {
  final PostWriteController controller;
  const PostMetaEditor({super.key, required this.controller});

  Future<DateTime?> _selectDate(
    BuildContext context, {
    DateTime? initialDateTime,
  }) async {
    DateTime? picked;
    await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: Theme.of(context).colorScheme.surface,
        child: SafeArea(
          top: false,
          child: CupertinoDatePicker(
            initialDateTime: initialDateTime,
            mode: CupertinoDatePickerMode.dateAndTime,
            use24hFormat: true,
            onDateTimeChanged: (DateTime newDate) {
              picked = newDate;
            },
          ),
        ),
      ),
    );
    return picked;
  }

  @override
  Widget build(BuildContext context) {
    final dateFormatter = DateFormat('y/M/d HH:mm:ss');
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        return Column(
          children: [
            TextField(
              controller: controller.titleController,
              decoration: InputDecoration(
                labelText: 'fieldPostTitle'.tr(),
                border: UnderlineInputBorder(),
              ),
              onTapOutside: (_) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
            ).padding(horizontal: 24),
            if (controller.mode == 'article') const Gap(4),
            if (controller.mode == 'article')
              TextField(
                controller: controller.descriptionController,
                maxLines: null,
                decoration: InputDecoration(
                  labelText: 'fieldPostDescription'.tr(),
                  border: UnderlineInputBorder(),
                ),
                onTapOutside: (_) =>
                    FocusManager.instance.primaryFocus?.unfocus(),
              ).padding(horizontal: 24),
            const Gap(12),
            ListTile(
              leading: const Icon(Symbols.event_available),
              title: Text('postPublishedAt').tr(),
              subtitle: Text(
                controller.publishedAt != null
                    ? dateFormatter.format(controller.publishedAt!)
                    : 'unset'.tr(),
              ),
              trailing: controller.publishedAt != null
                  ? IconButton(
                      icon: const Icon(Symbols.cancel),
                      onPressed: () {
                        controller.setPublishedAt(null);
                      },
                    )
                  : null,
              contentPadding: const EdgeInsets.only(left: 24, right: 18),
              onTap: () {
                _selectDate(
                  context,
                  initialDateTime: controller.publishedAt,
                ).then((value) {
                  controller.setPublishedAt(value);
                });
              },
            ),
            ListTile(
              leading: const Icon(Symbols.event_busy),
              title: Text('postPublishedUntil').tr(),
              subtitle: Text(
                controller.publishedUntil != null
                    ? dateFormatter.format(controller.publishedUntil!)
                    : 'unset'.tr(),
              ),
              trailing: controller.publishedUntil != null
                  ? IconButton(
                      icon: const Icon(Symbols.cancel),
                      onPressed: () {
                        controller.setPublishedUntil(null);
                      },
                    )
                  : null,
              contentPadding: const EdgeInsets.only(left: 24, right: 18),
              onTap: () {
                _selectDate(
                  context,
                  initialDateTime: controller.publishedUntil,
                ).then((value) {
                  controller.setPublishedUntil(value);
                });
              },
            ),
          ],
        ).padding(vertical: 8);
      },
    );
  }
}
