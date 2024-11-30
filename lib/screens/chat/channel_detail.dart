import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:surface/providers/channel.dart';
import 'package:surface/providers/sn_network.dart';
import 'package:surface/providers/user_directory.dart';
import 'package:surface/providers/userinfo.dart';
import 'package:surface/types/chat.dart';
import 'package:surface/widgets/account/account_image.dart';
import 'package:surface/widgets/dialog.dart';
import 'package:surface/widgets/loading_indicator.dart';

class ChannelDetailScreen extends StatefulWidget {
  final String scope;
  final String alias;
  const ChannelDetailScreen({
    super.key,
    required this.scope,
    required this.alias,
  });

  @override
  State<ChannelDetailScreen> createState() => _ChannelDetailScreenState();
}

class _ChannelDetailScreenState extends State<ChannelDetailScreen> {
  bool _isBusy = false;

  SnChannel? _channel;
  SnChannelMember? _profile;

  Future<void> _fetchChannel() async {
    setState(() => _isBusy = true);

    try {
      final chan = context.read<ChatChannelProvider>();
      _channel = await chan.getChannel('${widget.scope}:${widget.alias}');
    } catch (err) {
      if (!mounted) return;
      context.showErrorDialog(err);
    } finally {
      setState(() => _isBusy = false);
    }
  }

  Future<void> _fetchChannelProfile() async {
    setState(() => _isBusy = true);

    try {
      final sn = context.read<SnNetworkProvider>();
      final resp = await sn.client
          .get('/cgi/im/channels/${_channel!.keyPath}/members/me');
      _profile = SnChannelMember.fromJson(resp.data);
      _notifyLevel = _profile!.notify;
      if (!mounted) return;
      final ud = context.read<UserDirectoryProvider>();
      await ud.getAccount(_profile!.accountId);
    } catch (err) {
      if (!mounted) return;
      context.showErrorDialog(err);
    } finally {
      setState(() => _isBusy = false);
    }
  }

  Future<void> _deleteChannel() async {
    final confirm = await context.showConfirmDialog(
      'channelDelete'.tr(args: [_channel!.name]),
      'channelDeleteDescription'.tr(),
    );
    if (!confirm) return;
    if (!mounted) return;

    try {
      final sn = context.read<SnNetworkProvider>();
      await sn.client.delete(
        '/cgi/im/channels/${_channel!.realm?.alias ?? 'global'}/${_channel!.id}',
      );
      if (!mounted) return;
      Navigator.pop(context, false);
    } catch (err) {
      if (!mounted) return;
      context.showErrorDialog(err);
    }
  }

  Future<void> _leaveChannel() async {
    final confirm = await context.showConfirmDialog(
      'channelLeave'.tr(args: [_channel!.name]),
      'channelLeaveDescription'.tr(),
    );
    if (!confirm) return;
    if (!mounted) return;

    try {
      final sn = context.read<SnNetworkProvider>();
      await sn.client.delete(
        '/cgi/im/channels/${_channel!.realm?.alias ?? 'global'}/${_channel!.id}/members/me',
      );
      if (!mounted) return;
      Navigator.pop(context, false);
    } catch (err) {
      if (!mounted) return;
      context.showErrorDialog(err);
    }
  }

  int _notifyLevel = 0;
  bool _isUpdatingNotifyLevel = false;

  final kNotifyLevels = {
    0: 'channelNotifyLevelAll'.tr(),
    1: 'channelNotifyLevelMentioned'.tr(),
    2: 'channelNotifyLevelNone'.tr(),
  };

  Future<void> _updateNotifyLevel(int value) async {
    if (_isUpdatingNotifyLevel) return;

    setState(() => _isUpdatingNotifyLevel = true);

    try {
      final sn = context.read<SnNetworkProvider>();
      await sn.client.put(
        '/cgi/im/channels/${_channel!.keyPath}/members/me/notify',
        data: {'notify_level': value},
      );
      _notifyLevel = value;
      if (!mounted) return;
      context.showSnackbar('channelNotifyLevelApplied'.tr());
    } catch (err) {
      if (!mounted) return;
      context.showErrorDialog(err);
    } finally {
      setState(() => _isUpdatingNotifyLevel = false);
    }
  }

  void _showChannelProfileDetail() {
    showDialog(
      context: context,
      builder: (context) => _ChannelProfileDetailDialog(
        channel: _channel!,
        current: _profile!,
      ),
    ).then((value) {
      if (value != null && mounted) {
        Navigator.pop(context, true);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchChannel().then((_) {
      _fetchChannelProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ud = context.read<UserDirectoryProvider>();
    final ua = context.read<UserProvider>();

    final isOwned = ua.isAuthorized && _channel?.accountId == ua.user?.id;

    return Scaffold(
      appBar: AppBar(
        title: _channel != null ? Text(_channel!.name) : Text('loading').tr(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LoadingIndicator(isActive: _isBusy),
            const Gap(24),
            if (_channel != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _channel!.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    _channel!.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ).padding(horizontal: 24),
            const Gap(16),
            const Divider(),
            const Gap(12),
            if (_profile != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('channelDetailPersonalRegion')
                      .bold()
                      .fontSize(17)
                      .tr()
                      .padding(horizontal: 20, bottom: 4),
                  ListTile(
                    leading: const Icon(Symbols.notifications),
                    trailing: DropdownButtonHideUnderline(
                      child: DropdownButton2<int>(
                        isExpanded: true,
                        items: kNotifyLevels.entries
                            .map((item) => DropdownMenuItem<int>(
                                  enabled: !_isUpdatingNotifyLevel,
                                  value: item.key,
                                  child: Text(
                                    item.value,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ))
                            .toList(),
                        value: _notifyLevel,
                        onChanged: (int? value) {
                          if (value == null) return;
                          _updateNotifyLevel(value);
                        },
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.only(left: 16, right: 1),
                          height: 40,
                          width: 140,
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                        ),
                      ),
                    ),
                    title: Text('channelNotifyLevel').tr(),
                    subtitle: Text('channelNotifyLevelDescription').tr(),
                    contentPadding: const EdgeInsets.only(left: 24, right: 20),
                  ),
                  ListTile(
                    leading: AccountImage(
                      content:
                          ud.getAccountFromCache(_profile!.accountId)?.avatar,
                      radius: 18,
                    ),
                    trailing: const Icon(Symbols.chevron_right),
                    title: Text('channelEditProfile').tr(),
                    subtitle: Text(
                      (_profile?.nick?.isEmpty ?? true)
                          ? ud.getAccountFromCache(_profile!.accountId)!.nick
                          : _profile!.nick!,
                    ),
                    contentPadding: const EdgeInsets.only(left: 20, right: 20),
                    onTap: _showChannelProfileDetail,
                  ),
                  if (!isOwned)
                    ListTile(
                      leading: const Icon(Symbols.exit_to_app),
                      trailing: const Icon(Symbols.chevron_right),
                      title: Text('channelActionLeave').tr(),
                      subtitle: Text('channelActionLeaveDescription').tr(),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 24),
                      onTap: _leaveChannel,
                    ),
                ],
              ).padding(bottom: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('channelDetailAdminRegion')
                    .bold()
                    .fontSize(17)
                    .tr()
                    .padding(horizontal: 20, bottom: 4),
                ListTile(
                  leading: const Icon(Symbols.edit),
                  trailing: const Icon(Symbols.chevron_right),
                  title: Text('channelEdit').tr(),
                  subtitle: Text('channelEditDescription').tr(),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                  onTap: () {
                    GoRouter.of(context).pushNamed(
                      'chatManage',
                      queryParameters: {'editing': _channel!.keyPath},
                    ).then((value) {
                      if (value != null && context.mounted) {
                        Navigator.pop(context, value);
                      }
                    });
                  },
                ),
                if (isOwned)
                  ListTile(
                    leading: const Icon(Symbols.delete),
                    trailing: const Icon(Symbols.chevron_right),
                    title: Text('channelActionDelete').tr(),
                    subtitle: Text('channelActionDeleteDescription').tr(),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                    onTap: _deleteChannel,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ChannelProfileDetailDialog extends StatefulWidget {
  final SnChannel channel;
  final SnChannelMember current;
  const _ChannelProfileDetailDialog({
    required this.channel,
    required this.current,
  });

  @override
  State<_ChannelProfileDetailDialog> createState() =>
      _ChannelProfileDetailDialogState();
}

class _ChannelProfileDetailDialogState
    extends State<_ChannelProfileDetailDialog> {
  bool _isBusy = false;

  final TextEditingController _nickController = TextEditingController();

  Future<void> _updateProfile() async {
    setState(() => _isBusy = true);

    try {
      final sn = context.read<SnNetworkProvider>();
      await sn.client.put(
        '/cgi/im/channels/${widget.channel.keyPath}/members/me',
        data: {'nick': _nickController.text},
      );
      if (!mounted) return;
      Navigator.pop(context, true);
    } catch (err) {
      if (!mounted) return;
      context.showErrorDialog(err);
    } finally {
      setState(() => _isBusy = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _nickController.text = widget.current.nick ?? '';
  }

  @override
  void dispose() {
    _nickController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('channelProfileEdit').tr(),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _nickController,
            decoration: InputDecoration(
              labelText: 'fieldChannelProfileNick'.tr(),
              helperText: 'fieldChannelProfileNickHint'.tr(),
              helperMaxLines: 2,
            ),
            onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _isBusy ? null : () => Navigator.pop(context),
          child: Text('dialogCancel').tr(),
        ),
        TextButton(
          onPressed: _isBusy ? null : _updateProfile,
          child: Text('apply').tr(),
        ),
      ],
    );
  }
}
