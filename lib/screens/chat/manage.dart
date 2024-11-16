import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:surface/providers/sn_network.dart';
import 'package:surface/widgets/dialog.dart';
import 'package:surface/widgets/loading_indicator.dart';
import 'package:uuid/uuid.dart';

class ChatManageScreen extends StatefulWidget {
  final String? editingChannelAlias;
  const ChatManageScreen({super.key, this.editingChannelAlias});

  @override
  State<ChatManageScreen> createState() => _ChatManageScreenState();
}

class _ChatManageScreenState extends State<ChatManageScreen> {
  bool _isBusy = false;

  final _aliasController = TextEditingController();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  Future<void> _performAction() async {
    final uuid = const Uuid();
    final sn = context.read<SnNetworkProvider>();

    setState(() => _isBusy = true);

    // TODO Add realm support
    // final scope = widget.realm != null ? widget.realm!.alias : 'global';
    final scope = 'global';
    final payload = {
      'alias': _aliasController.text.isNotEmpty
          ? _aliasController.text.toLowerCase()
          : uuid.v4().replaceAll('-', '').substring(0, 12),
      'name': _nameController.text,
      'description': _descriptionController.text,
    };

    try {
      final resp = await sn.client.request(
        widget.editingChannelAlias != null
            ? '/cgi/im/channels/$scope/${widget.editingChannelAlias}'
            : '/cgi/im/channels/$scope',
        data: payload,
        options: Options(
          method: widget.editingChannelAlias != null ? 'PUT' : 'POST',
        ),
      );
      log(jsonEncode(resp.data));
      // ignore: use_build_context_synchronously
      if (context.mounted) Navigator.pop(context, resp.data);
    } catch (err) {
      // ignore: use_build_context_synchronously
      if (context.mounted) context.showErrorDialog(err);
    }

    setState(() => _isBusy = false);
  }

  @override
  void dispose() {
    super.dispose();
    _aliasController.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.editingChannelAlias != null
            ? Text('screenChatManage').tr()
            : Text('screenChatNew').tr(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            LoadingIndicator(isActive: _isBusy),
            const Gap(24),
            TextField(
              controller: _aliasController,
              decoration: InputDecoration(
                border: const UnderlineInputBorder(),
                labelText: 'fieldChatAlias'.tr(),
                helperText: 'fieldChatAliasHint'.tr(),
                helperMaxLines: 2,
              ),
              onTapOutside: (_) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
            ),
            const Gap(4),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                border: const UnderlineInputBorder(),
                labelText: 'fieldChatName'.tr(),
              ),
              onTapOutside: (_) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
            ),
            const Gap(4),
            TextField(
              controller: _descriptionController,
              maxLines: null,
              minLines: 3,
              decoration: InputDecoration(
                border: const UnderlineInputBorder(),
                labelText: 'fieldChatDescription'.tr(),
              ),
              onTapOutside: (_) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
            ),
            const Gap(12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: _isBusy ? null : _performAction,
                  icon: const Icon(Symbols.save),
                  label: Text('apply').tr(),
                ),
              ],
            ),
          ],
        ).padding(horizontal: 24),
      ),
    );
  }
}
