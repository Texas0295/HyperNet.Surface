import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:surface/providers/sn_network.dart';
import 'package:surface/providers/userinfo.dart';
import 'package:surface/types/post.dart';
import 'package:surface/widgets/dialog.dart';
import 'package:surface/widgets/loading_indicator.dart';
import 'package:surface/widgets/navigation/app_scaffold.dart';

class AccountPublisherEditScreen extends StatefulWidget {
  final String name;
  const AccountPublisherEditScreen({super.key, required this.name});

  @override
  State<AccountPublisherEditScreen> createState() =>
      _AccountPublisherEditScreenState();
}

class _AccountPublisherEditScreenState
    extends State<AccountPublisherEditScreen> {
  bool _isBusy = false;

  SnPublisher? _publisher;

  String? _avatar;
  String? _banner;

  final TextEditingController _nickController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Future<void> _fetchPublisher() async {
    final sn = context.read<SnNetworkProvider>();
    final ua = context.read<UserProvider>();
    if (!ua.isAuthorized) return;

    setState(() => _isBusy = true);

    try {
      final resp = await sn.client.get('/cgi/co/publishers/${widget.name}');
      _publisher = SnPublisher.fromJson(resp.data);
      _syncWidget();
    } catch (err) {
      context.showErrorDialog(err);
    } finally {
      setState(() => _isBusy = false);
    }
  }

  Future<void> _performAction() async {
    final sn = context.read<SnNetworkProvider>();
    final ua = context.read<UserProvider>();
    if (!ua.isAuthorized) return;

    setState(() => _isBusy = true);

    try {
      await sn.client.put('/cgi/co/publishers/${widget.name}', data: {
        'avatar': _avatar,
        'banner': _banner,
        'nick': _nickController.text,
        'name': _nameController.text,
        'description': _descriptionController.text,
      });
      Navigator.pop(context, true);
    } catch (err) {
      context.showErrorDialog(err);
    } finally {
      setState(() => _isBusy = false);
    }
  }

  void _syncWidget() {
    _avatar = _publisher!.avatar;
    _banner = _publisher!.banner;
    _nickController.text = _publisher!.nick;
    _nameController.text = _publisher!.name;
    _descriptionController.text = _publisher!.description;
  }

  void _syncWithAccount() {
    final ua = context.read<UserProvider>();
    _avatar = ua.user!.avatar;
    _banner = ua.user!.banner;
    _nickController.text = ua.user!.nick;
    _nameController.text = ua.user!.name;
    _descriptionController.text = ua.user!.description;
  }

  @override
  void initState() {
    super.initState();
    _fetchPublisher();
  }

  @override
  void dispose() {
    _nickController.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            LoadingIndicator(isActive: _isBusy),
            TextField(
              controller: _nameController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'fieldUsername'.tr(),
                helperText: 'fieldUsernameCannotEditHint'.tr(),
              ),
              onTapOutside: (_) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
            ),
            const Gap(4),
            TextField(
              controller: _nickController,
              decoration: InputDecoration(
                labelText: 'fieldNickname'.tr(),
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
                labelText: 'fieldDescription'.tr(),
              ),
              onTapOutside: (_) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
            ),
            const Gap(12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: _syncWithAccount,
                  label: Text('publisherSyncWithAccount').tr(),
                  icon: const Icon(Symbols.sync),
                ),
                ElevatedButton.icon(
                  onPressed: _isBusy ? null : _performAction,
                  label: Text('apply').tr(),
                  icon: const Icon(Symbols.save),
                ),
              ],
            )
          ],
        ).padding(horizontal: 16, vertical: 12),
      ),
    );
  }
}
