import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:surface/providers/relationship.dart';
import 'package:surface/providers/sn_network.dart';
import 'package:surface/types/account.dart';
import 'package:surface/widgets/account/account_image.dart';
import 'package:surface/widgets/dialog.dart';
import 'package:surface/widgets/loading_indicator.dart';

const kFriendStatus = {
  0: 'friendStatusPending',
  1: 'friendStatusActive',
  2: 'friendStatusBlocked',
  3: 'friendStatusWaiting',
};

class FriendScreen extends StatefulWidget {
  const FriendScreen({super.key});

  @override
  State<FriendScreen> createState() => _FriendScreenState();
}

class _FriendScreenState extends State<FriendScreen> {
  bool _isBusy = false;

  List<SnRelationship> _requests = List.empty();
  List<SnRelationship> _relations = List.empty();
  List<SnRelationship> _blocks = List.empty();

  Future<void> _fetchRelations() async {
    setState(() => _isBusy = true);

    try {
      final sn = context.read<SnNetworkProvider>();
      final resp = await sn.client.get('/cgi/id/users/me/relations?status=1');
      _relations = List<SnRelationship>.from(
        resp.data?.map((e) => SnRelationship.fromJson(e)) ?? [],
      );
    } catch (err) {
      if (!mounted) return;
      context.showErrorDialog(err);
    } finally {
      setState(() => _isBusy = false);
    }
  }

  Future<void> _fetchRequests() async {
    setState(() => _isBusy = true);

    try {
      final sn = context.read<SnNetworkProvider>();
      final resp = await sn.client.get('/cgi/id/users/me/relations?status=0,3');
      _requests = List<SnRelationship>.from(
        resp.data?.map((e) => SnRelationship.fromJson(e)) ?? [],
      );
    } catch (err) {
      if (!mounted) return;
      context.showErrorDialog(err);
    } finally {
      setState(() => _isBusy = false);
    }
  }

  Future<void> _fetchBlocks() async {
    setState(() => _isBusy = true);

    try {
      final sn = context.read<SnNetworkProvider>();
      final resp = await sn.client.get('/cgi/id/users/me/relations?status=2');
      _blocks = List<SnRelationship>.from(
        resp.data?.map((e) => SnRelationship.fromJson(e)) ?? [],
      );
    } catch (err) {
      if (!mounted) return;
      context.showErrorDialog(err);
    } finally {
      setState(() => _isBusy = false);
    }
  }

  bool _isUpdating = false;

  Future<void> _changeRelation(SnRelationship relation, int dstStatus) async {
    setState(() => _isUpdating = true);

    try {
      final rel = context.read<SnRelationshipProvider>();
      await rel.updateRelationship(
        relation.relatedId,
        dstStatus,
        relation.permNodes,
      );
      if (!mounted) return;
      _fetchRelations();
    } catch (err) {
      if (!mounted) return;
      context.showErrorDialog(err);
    } finally {
      setState(() => _isUpdating = false);
    }
  }

  Future<void> _deleteRelation(SnRelationship relation) async {
    final confirm = await context.showConfirmDialog(
      'friendDelete'.tr(args: [relation.related?.nick ?? 'unknown'.tr()]),
      'friendDeleteDescription'.tr(args: [
        relation.related?.nick ?? 'unknown'.tr(),
      ]),
    );
    if (!confirm) return;
    if (!mounted) return;

    setState(() => _isUpdating = true);

    try {
      final rel = context.read<SnRelationshipProvider>();
      await rel.deleteRelationship(relation.relatedId);
      if (!mounted) return;
      _fetchRelations();
    } catch (err) {
      if (!mounted) return;
      context.showErrorDialog(err);
    } finally {
      setState(() => _isUpdating = false);
    }
  }

  void _showRequests() {
    showModalBottomSheet(
      context: context,
      builder: (context) => _FriendshipPopupWidget(relations: _requests),
    ).then((value) {
      if (value != null) {
        _fetchRequests();
        _fetchRelations();
      }
    });
  }

  void _showBlocks() {
    showModalBottomSheet(
      context: context,
      builder: (context) => _FriendshipPopupWidget(relations: _blocks),
    ).then((value) {
      if (value != null) {
        _fetchBlocks();
        _fetchRelations();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchRelations();
    _fetchRequests();
    _fetchBlocks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('screenFriend').tr(),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Symbols.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => _NewFriendWidget(),
          );
        },
      ),
      body: Column(
        children: [
          LoadingIndicator(isActive: _isBusy || _isUpdating),
          if (_requests.isNotEmpty)
            ListTile(
              title: Text('friendRequests').tr(),
              subtitle: Text(
                'friendRequestsDescription',
              ).plural(_requests.length),
              contentPadding: const EdgeInsets.symmetric(horizontal: 24),
              leading: const Icon(Symbols.group_add),
              trailing: const Icon(Symbols.chevron_right),
              onTap: _showRequests,
            ),
          if (_blocks.isNotEmpty)
            ListTile(
              title: Text('friendBlocklist').tr(),
              subtitle: Text(
                'friendBlocklistDescription',
              ).plural(_blocks.length),
              contentPadding: const EdgeInsets.symmetric(horizontal: 24),
              leading: const Icon(Symbols.block),
              trailing: const Icon(Symbols.chevron_right),
              onTap: _showBlocks,
            ),
          if (_requests.isNotEmpty || _blocks.isNotEmpty)
            const Divider(height: 1),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => Future.wait([
                _fetchRelations(),
                _fetchRequests(),
              ]),
              child: ListView.builder(
                itemCount: _relations.length,
                itemBuilder: (context, index) {
                  final relation = _relations[index];
                  final other = relation.related;
                  return ListTile(
                    contentPadding: const EdgeInsets.only(right: 24, left: 16),
                    leading: AccountImage(content: other?.avatar),
                    title: Text(other?.nick ?? 'unknown'),
                    subtitle: Text(other?.nick ?? 'unknown'),
                    trailing: SizedBox(
                      height: 48,
                      width: 120,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: _isUpdating
                                    ? null
                                    : () => _changeRelation(relation, 2),
                                child: Text('friendBlock').tr(),
                              ),
                              const Gap(8),
                              InkWell(
                                onTap: _isUpdating
                                    ? null
                                    : () => _deleteRelation(relation),
                                child: Text('friendDeleteAction').tr(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NewFriendWidget extends StatefulWidget {
  const _NewFriendWidget({super.key});

  @override
  State<_NewFriendWidget> createState() => _NewFriendWidgetState();
}

class _NewFriendWidgetState extends State<_NewFriendWidget> {
  bool _isBusy = false;

  final TextEditingController _relatedController = TextEditingController();

  Future<void> _sendRequest() async {
    if (_relatedController.text.isEmpty) return;

    setState(() => _isBusy = true);

    try {
      final sn = context.read<SnNetworkProvider>();
      await sn.client.post('/cgi/id/users/me/relations', data: {
        'related': _relatedController.text,
      });
      if (!mounted) return;
      Navigator.pop(context, true);
      context.showSnackbar('friendRequestSent'.tr());
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
          'friendNew',
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
            labelText: 'fieldFriendRelatedName'.tr(),
            suffix: SizedBox(
              height: 24,
              child: IconButton(
                onPressed: _isBusy ? null : () => _sendRequest(),
                icon: Icon(Symbols.send),
                visualDensity:
                    const VisualDensity(horizontal: -4, vertical: -4),
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

class _FriendshipPopupWidget extends StatefulWidget {
  final List<SnRelationship> relations;
  const _FriendshipPopupWidget({super.key, required this.relations});

  @override
  State<_FriendshipPopupWidget> createState() => _FriendshipPopupWidgetState();
}

class _FriendshipPopupWidgetState extends State<_FriendshipPopupWidget> {
  bool _isBusy = false;

  Future<void> _acceptRequest(SnRelationship relation) async {
    setState(() => _isBusy = true);

    try {
      final rel = context.read<SnRelationshipProvider>();
      await rel.acceptFriendRequest(relation.relatedId);
      if (!mounted) return;
      Navigator.pop(context, true);
    } catch (err) {
      if (!mounted) return;
      context.showErrorDialog(err);
    } finally {
      setState(() => _isBusy = false);
    }
  }

  Future<void> _declineRequest(SnRelationship relation) async {
    setState(() => _isBusy = true);

    try {
      final rel = context.read<SnRelationshipProvider>();
      await rel.declineFriendRequest(relation.relatedId);
      if (!mounted) return;
      Navigator.pop(context, true);
    } catch (err) {
      if (!mounted) return;
      context.showErrorDialog(err);
    } finally {
      setState(() => _isBusy = false);
    }
  }

  Future<void> _changeRelation(SnRelationship relation, int dstStatus) async {
    setState(() => _isBusy = true);

    try {
      final rel = context.read<SnRelationshipProvider>();
      await rel.updateRelationship(
        relation.relatedId,
        dstStatus,
        relation.permNodes,
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

  Future<void> _deleteRelation(SnRelationship relation) async {
    final confirm = await context.showConfirmDialog(
      'friendDelete'.tr(args: [relation.related?.nick ?? 'unknown'.tr()]),
      'friendDeleteDescription'.tr(args: [
        relation.related?.nick ?? 'unknown'.tr(),
      ]),
    );
    if (!confirm) return;
    if (!mounted) return;

    setState(() => _isBusy = true);

    try {
      final rel = context.read<SnRelationshipProvider>();
      await rel.deleteRelationship(relation.relatedId);
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
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.relations.length,
      itemBuilder: (context, index) {
        final relation = widget.relations[index];
        final other = relation.related;
        return ListTile(
          contentPadding: const EdgeInsets.only(right: 24, left: 16),
          leading: AccountImage(content: other?.avatar),
          title: Text(other?.nick ?? 'unknown'.tr()),
          subtitle: Text(other?.nick ?? 'unknown'.tr()),
          trailing: SizedBox(
            height: 48,
            width: 120,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(kFriendStatus[relation.status] ?? 'unknown')
                    .tr()
                    .opacity(0.75),
                if (relation.status == 0)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: _isBusy ? null : () => _acceptRequest(relation),
                        child: Text('friendRequestAccept').tr(),
                      ),
                      const Gap(8),
                      InkWell(
                        onTap: _isBusy ? null : () => _declineRequest(relation),
                        child: Text('friendRequestDecline').tr(),
                      ),
                    ],
                  )
                else if (relation.status == 2)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap:
                            _isBusy ? null : () => _changeRelation(relation, 1),
                        child: Text('friendUnblock').tr(),
                      ),
                      const Gap(8),
                      InkWell(
                        onTap: _isBusy ? null : () => _deleteRelation(relation),
                        child: Text('friendDeleteAction').tr(),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
