import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:surface/providers/sn_network.dart';
import 'package:surface/providers/user_directory.dart';
import 'package:surface/providers/userinfo.dart';
import 'package:surface/types/realm.dart';
import 'package:surface/widgets/account/account_image.dart';
import 'package:surface/widgets/dialog.dart';
import 'package:very_good_infinite_list/very_good_infinite_list.dart';

import '../../types/post.dart';

class RealmDetailScreen extends StatefulWidget {
  final String alias;

  const RealmDetailScreen({super.key, required this.alias});

  @override
  State<RealmDetailScreen> createState() => _RealmDetailScreenState();
}

class _RealmDetailScreenState extends State<RealmDetailScreen> {
  SnRealm? _realm;

  Future<void> _fetchRealm() async {
    try {
      final sn = context.read<SnNetworkProvider>();
      final resp = await sn.client.get('/cgi/id/realms/${widget.alias}');
      _realm = SnRealm.fromJson(resp.data);
    } catch (err) {
      if (!mounted) return;
      context.showErrorDialog(err);
      rethrow;
    } finally {
      setState(() {});
    }
  }

  List<SnPublisher>? _publishers;

  Future<void> _fetchPublishers() async {
    try {
      final sn = context.read<SnNetworkProvider>();
      final resp = await sn.client.get('/cgi/co/publishers?realm=${widget.alias}');
      _publishers = List<SnPublisher>.from(
        resp.data?.map((e) => SnPublisher.fromJson(e)) ?? [],
      );
    } catch (err) {
      if (mounted) context.showErrorDialog(err);
      rethrow;
    } finally {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchRealm().then((_) {
      _fetchPublishers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            // These are the slivers that show up in the "outer" scroll view.
            return <Widget>[
              SliverOverlapAbsorber(
                // This widget takes the overlapping behavior of the SliverAppBar,
                // and redirects it to the SliverOverlapInjector below. If it is
                // missing, then it is possible for the nested "inner" scroll view
                // below to end up under the SliverAppBar even when the inner
                // scroll view thinks it has not been scrolled.
                // This is not necessary if the "headerSliverBuilder" only builds
                // widgets that do not overlap the next sliver.
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  title: Text(_realm?.name ?? 'loading'.tr()),
                  bottom: TabBar(
                    tabs: [
                      Tab(icon: const Icon(Symbols.home)),
                      Tab(icon: const Icon(Symbols.group)),
                      Tab(icon: const Icon(Symbols.settings)),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              _RealmDetailHomeWidget(realm: _realm, publishers: _publishers),
              _RealmMemberListWidget(realm: _realm),
              _RealmSettingsWidget(
                realm: _realm,
                onUpdate: () {
                  _fetchRealm();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RealmDetailHomeWidget extends StatelessWidget {
  final SnRealm? realm;
  final List<SnPublisher>? publishers;

  const _RealmDetailHomeWidget({super.key, required this.realm, this.publishers});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(24),
        if (realm != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                realm!.name,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                realm!.description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ).padding(horizontal: 24),
        const Gap(16),
        const Divider(),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: publishers?.length ?? 0,
            itemBuilder: (context, idx) {
              final ele = publishers![idx];
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                leading: AccountImage(
                  content: ele.avatar,
                  fallbackWidget: const Icon(Symbols.group, size: 24),
                ),
                title: Text(ele.nick),
                subtitle: Text('@${ele.name}'),
                trailing: const Icon(Symbols.chevron_right),
                onTap: () {
                  GoRouter.of(context).pushNamed(
                    'postPublisher',
                    pathParameters: {'name': ele.name},
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _RealmMemberListWidget extends StatefulWidget {
  final SnRealm? realm;

  const _RealmMemberListWidget({super.key, this.realm});

  @override
  State<_RealmMemberListWidget> createState() => _RealmMemberListWidgetState();
}

class _RealmMemberListWidgetState extends State<_RealmMemberListWidget> {
  bool _isBusy = false;

  int? _totalCount;
  final List<SnRealmMember> _members = List.empty(growable: true);

  Future<void> _fetchMembers() async {
    setState(() => _isBusy = true);

    try {
      final ud = context.read<UserDirectoryProvider>();
      final sn = context.read<SnNetworkProvider>();
      final resp = await sn.client.get('/cgi/id/realms/${widget.realm!.alias}/members', queryParameters: {
        'take': 10,
        'offset': 0,
      });

      final out = List<SnRealmMember>.from(
        resp.data['data']?.map((e) => SnRealmMember.fromJson(e)) ?? [],
      );

      await ud.listAccount(out.map((ele) => ele.accountId).toSet());

      _totalCount = resp.data['count'];
      _members.addAll(out);
    } catch (err) {
      if (!mounted) return;
      context.showErrorDialog(err);
    } finally {
      setState(() => _isBusy = false);
    }
  }

  bool _isUpdating = false;

  Future<void> _deleteMember(SnRealmMember member) async {
    if (_isUpdating) return;

    setState(() => _isUpdating = true);

    try {
      final sn = context.read<SnNetworkProvider>();
      await sn.client.delete(
        '/cgi/id/realms/${widget.realm!.alias}/members/${member.id}',
      );
      if (!mounted) return;
      _members.clear();
      _fetchMembers();
    } catch (err) {
      if (!mounted) return;
      context.showErrorDialog(err);
    } finally {
      setState(() => _isUpdating = false);
    }
  }

  void _showMemberAdd() {
    showModalBottomSheet(
      context: context,
      builder: (context) => _NewRealmMemberWidget(
        realm: widget.realm!,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchMembers();
  }

  @override
  Widget build(BuildContext context) {
    final ud = context.read<UserDirectoryProvider>();

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 24),
            leading: const Icon(Symbols.group_add),
            trailing: const Icon(Symbols.chevron_right),
            title: Text('realmMemberAdd').tr(),
            subtitle: Text('realmMemberAddDescription').tr(),
            onTap: _showMemberAdd,
          ),
        ),
        SliverToBoxAdapter(child: const Divider(height: 1)),
        SliverInfiniteList(
          // padding: EdgeInsets.zero,
          itemCount: _members.length,
          isLoading: _isBusy,
          hasReachedMax: _totalCount != null && _members.length >= _totalCount!,
          onFetchData: _fetchMembers,
          itemBuilder: (context, index) {
            final member = _members[index];
            return ListTile(
              contentPadding: const EdgeInsets.only(right: 24, left: 16),
              leading: AccountImage(
                content: ud.getAccountFromCache(member.accountId)?.avatar,
                fallbackWidget: const Icon(Symbols.group, size: 24),
              ),
              title: Text(
                ud.getAccountFromCache(member.accountId)?.nick ?? 'unknown'.tr(),
              ),
              subtitle: Text(
                ud.getAccountFromCache(member.accountId)?.name ?? 'unknown'.tr(),
              ),
              trailing: IconButton(
                icon: const Icon(Symbols.person_remove),
                onPressed: _isUpdating ? null : () => _deleteMember(member),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _NewRealmMemberWidget extends StatefulWidget {
  final SnRealm realm;

  const _NewRealmMemberWidget({super.key, required this.realm});

  @override
  State<_NewRealmMemberWidget> createState() => _NewRealmMemberWidgetState();
}

class _NewRealmMemberWidgetState extends State<_NewRealmMemberWidget> {
  bool _isBusy = false;

  final TextEditingController _relatedController = TextEditingController();

  Future<void> _performAction() async {
    if (_relatedController.text.isEmpty) return;

    setState(() => _isBusy = true);

    try {
      final sn = context.read<SnNetworkProvider>();
      await sn.client.post(
        '/cgi/id/realms/${widget.realm.alias}/members',
        data: {
          'related': _relatedController.text,
        },
      );
      if (!mounted) return;
      Navigator.pop(context, true);
      context.showSnackbar('channelMemberAdded'.tr());
    } catch (err) {
      if (!mounted) return;
      context.showErrorDialog(err);
    } finally {
      setState(() => _isBusy = false);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _relatedController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StyledWidget(Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'realmMemberAdd',
          style: Theme.of(context).textTheme.titleLarge,
        ).tr(),
        const Gap(12),
        TextField(
          controller: _relatedController,
          readOnly: _isBusy,
          autocorrect: false,
          autofocus: true,
          textCapitalization: TextCapitalization.none,
          decoration: InputDecoration(
            labelText: 'fieldMemberRelatedName'.tr(),
            suffix: SizedBox(
              height: 24,
              child: IconButton(
                onPressed: _isBusy ? null : () => _performAction(),
                icon: Icon(Symbols.send),
                visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                padding: EdgeInsets.zero,
              ),
            ),
          ),
          onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
        )
      ],
    )).padding(all: 24);
  }
}

class _RealmSettingsWidget extends StatefulWidget {
  final SnRealm? realm;
  final Function() onUpdate;

  const _RealmSettingsWidget({super.key, required this.realm, required this.onUpdate});

  @override
  State<_RealmSettingsWidget> createState() => _RealmSettingsWidgetState();
}

class _RealmSettingsWidgetState extends State<_RealmSettingsWidget> {
  bool _isBusy = false;

  Future<void> _deleteRealm() async {
    final confirm = await context.showConfirmDialog(
      'realmDelete'.tr(args: ['#${widget.realm!.alias}']),
      'realmDeleteDescription'.tr(),
    );
    if (!confirm) return;

    if (!mounted) return;
    final sn = context.read<SnNetworkProvider>();

    setState(() => _isBusy = true);

    try {
      await sn.client.delete('/cgi/id/realms/${widget.realm!.alias}');
      if (!mounted) return;
      Navigator.pop(context, true);
      context.showSnackbar('realmDeleted'.tr(args: [
        '#${widget.realm!.alias}',
      ]));
    } catch (err) {
      if (!mounted) return;
      context.showErrorDialog(err);
    } finally {
      setState(() => _isBusy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ua = context.read<UserProvider>();

    final isOwned = ua.isAuthorized && widget.realm?.accountId == ua.user?.id;

    return Column(
      children: [
        const Gap(16),
        ListTile(
          leading: const Icon(Symbols.edit),
          trailing: const Icon(Symbols.chevron_right),
          title: Text('realmEdit').tr(),
          subtitle: Text('realmEditDescription').tr(),
          contentPadding: const EdgeInsets.symmetric(horizontal: 24),
          onTap: () {
            GoRouter.of(context).pushNamed(
              'realmManage',
              queryParameters: {'editing': widget.realm!.alias},
            ).then((value) {
              if (value != null) {
                widget.onUpdate();
              }
            });
          },
        ),
        if (isOwned)
          ListTile(
            leading: const Icon(Symbols.delete),
            trailing: const Icon(Symbols.chevron_right),
            title: Text('realmActionDelete').tr(),
            subtitle: Text('realmActionDeleteDescription').tr(),
            contentPadding: const EdgeInsets.symmetric(horizontal: 24),
            onTap: _isBusy ? null : _deleteRealm,
          ),
      ],
    );
  }
}
