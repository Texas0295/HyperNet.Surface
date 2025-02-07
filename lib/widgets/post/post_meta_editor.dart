import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:surface/controllers/post_write_controller.dart';
import 'package:surface/widgets/account/account_select.dart';
import 'package:surface/widgets/post/post_tags_field.dart';

const Map<int, String> kPostVisibilityLevel = {
  0: 'postVisibilityAll',
  1: 'postVisibilityFriends',
  2: 'postVisibilitySelected',
  3: 'postVisibilityFiltered',
  4: 'postVisibilityNone',
};

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

  void _selectVisibleUser(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => AccountSelect(
        title: 'postVisibleUsers'.tr(),
        initialSelection: controller.visibleUsers,
        onMultipleSelect: (value) {
          controller.setVisibleUsers(value.map((ele) => ele.id).toList());
        },
      ),
    );
  }

  void _selectInvisibleUser(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => AccountSelect(
        title: 'postInvisibleUsers'.tr(),
        initialSelection: controller.invisibleUsers,
        onMultipleSelect: (value) {
          controller.setInvisibleUsers(value.map((ele) => ele.id).toList());
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dateFormatter = DateFormat('y/M/d HH:mm:ss');
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 8),
          child: Column(
            children: [
              if (controller.mode == 'stories')
                TextField(
                  controller: controller.titleController,
                  decoration: InputDecoration(
                    labelText: 'fieldPostTitle'.tr(),
                    border: UnderlineInputBorder(),
                  ),
                  onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
                ).padding(horizontal: 24),
              const Gap(4),
              PostTagsField(
                initialTags: controller.tags,
                labelText: 'fieldPostTags'.tr(),
                onUpdate: (value) {
                  controller.setTags(value);
                },
              ).padding(horizontal: 24),
              const Gap(4),
              PostCategoriesField(
                initialCategories: controller.categories,
                labelText: 'fieldPostCategories'.tr(),
                onUpdate: (value) {
                  controller.setCategories(value);
                },
              ).padding(horizontal: 24),
              const Gap(4),
              TextField(
                controller: controller.aliasController,
                decoration: InputDecoration(
                  labelText: 'fieldPostAlias'.tr(),
                  helperText: 'fieldPostAliasHint'.tr(),
                  helperMaxLines: 2,
                  border: UnderlineInputBorder(),
                ),
                onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
              ).padding(horizontal: 24),
              const Gap(12),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                leading: const Icon(Symbols.visibility),
                title: Text('postVisibility').tr(),
                subtitle: Text('postVisibilityDescription').tr(),
                trailing: SizedBox(
                  width: 180,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<int>(
                      isExpanded: true,
                      items: kPostVisibilityLevel.entries
                          .map(
                            (entry) => DropdownMenuItem<int>(
                              value: entry.key,
                              child: Text(
                                entry.value,
                                style: const TextStyle(fontSize: 14),
                              ).tr(),
                            ),
                          )
                          .toList(),
                      value: controller.visibility,
                      onChanged: (int? value) {
                        if (value != null) {
                          controller.setVisibility(value);
                        }
                      },
                      buttonStyleData: const ButtonStyleData(
                        height: 40,
                        padding: EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 8,
                        ),
                      ),
                      menuItemStyleData: const MenuItemStyleData(height: 40),
                    ),
                  ),
                ),
              ),
              if (controller.visibility == 2)
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                  leading: Icon(Symbols.person),
                  trailing: Icon(Symbols.chevron_right),
                  title: Text('postVisibleUsers').tr(),
                  subtitle: Text('postSelectedUsers').plural(controller.visibleUsers.length),
                  onTap: () {
                    _selectVisibleUser(context);
                  },
                ),
              if (controller.visibility == 3)
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                  leading: Icon(Symbols.person),
                  trailing: Icon(Symbols.chevron_right),
                  title: Text('postInvisibleUsers').tr(),
                  subtitle: Text('postSelectedUsers').plural(controller.invisibleUsers.length),
                  onTap: () {
                    _selectInvisibleUser(context);
                  },
                ),
              ListTile(
                leading: const Icon(Symbols.event_available),
                title: Text('postPublishedAt').tr(),
                subtitle: Text(
                  controller.publishedAt != null ? dateFormatter.format(controller.publishedAt!) : 'unset'.tr(),
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
                  controller.publishedUntil != null ? dateFormatter.format(controller.publishedUntil!) : 'unset'.tr(),
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
          ).padding(vertical: 8),
        );
      },
    );
  }
}
