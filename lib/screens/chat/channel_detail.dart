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
                  // TODO add notify level modifier
                  // TODO impl this
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
                    onTap: () {},
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
