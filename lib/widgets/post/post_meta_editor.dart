import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:styled_widget/styled_widget.dart';

class PostMetaResult {
  final String title;
  final String description;

  PostMetaResult({required this.title, required this.description});
}

class PostMetaEditor extends StatefulWidget {
  final String? initialTitle;
  final String? initialDescription;
  const PostMetaEditor({super.key, this.initialTitle, this.initialDescription});

  @override
  State<PostMetaEditor> createState() => _PostMetaEditorState();
}

class _PostMetaEditorState extends State<PostMetaEditor> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _applyChanges() {
    Navigator.pop(
      context,
      PostMetaResult(
        title: _titleController.text,
        description: _descriptionController.text,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.initialTitle ?? '';
    _descriptionController.text = widget.initialDescription ?? '';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _titleController,
          decoration: InputDecoration(
            labelText: 'fieldPostTitle'.tr(),
            border: UnderlineInputBorder(),
          ),
          onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
        ),
        const Gap(4),
        TextField(
          controller: _descriptionController,
          maxLines: null,
          decoration: InputDecoration(
            labelText: 'fieldPostDescription'.tr(),
            border: UnderlineInputBorder(),
          ),
          onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
        ),
        const Gap(12),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton.icon(
              onPressed: _applyChanges,
              icon: const Icon(Symbols.save),
              label: Text('apply').tr(),
            ),
          ],
        )
      ],
    ).padding(horizontal: 24, vertical: 8);
  }
}
