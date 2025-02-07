import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:surface/providers/sn_network.dart';
import 'package:surface/providers/user_directory.dart';
import 'package:surface/types/account.dart';
import 'package:surface/widgets/account/account_image.dart';

class AccountSelect extends StatefulWidget {
  final String title;
  final Widget? Function(SnAccount item)? trailingBuilder;
  final List<int>? initialSelection;
  final Function(List<SnAccount>)? onMultipleSelect;

  const AccountSelect({
    super.key,
    required this.title,
    this.trailingBuilder,
    this.initialSelection,
    this.onMultipleSelect,
  });

  @override
  State<AccountSelect> createState() => _AccountSelectState();
}

class _AccountSelectState extends State<AccountSelect> {
  final TextEditingController _probeController = TextEditingController();

  final List<SnAccount> _relativeUsers = List.empty(growable: true);
  final List<SnAccount> _pendingUsers = List.empty(growable: true);
  final List<SnAccount> _selectedUsers = List.empty(growable: true);

  final int _accountId = 0;

  Future<void> _revertSelectedUsers() async {
    if (widget.initialSelection?.isEmpty ?? true) return;
    final ud = context.read<UserDirectoryProvider>();
    final result = await ud.listAccount(widget.initialSelection!);

    setState(() {
      _selectedUsers.addAll(result.where((ele) => ele != null).cast());
    });
  }

  Future<void> _getFriends() async {
    final sn = context.read<SnNetworkProvider>();
    final resp = await sn.client.get('/cgi/id/users/me/relations?status=1');

    setState(() {
      _relativeUsers.addAll(
        resp.data?.map((e) => SnRelationship.fromJson(e)) ?? [],
      );
    });
  }

  Future<void> _searchAccount() async {
    if (_probeController.text.isEmpty) return;

    final sn = context.read<SnNetworkProvider>();

    final resp = await sn.client.get(
      '/cgi/id/users/search?probe=${_probeController.text}',
    );

    setState(() {
      _pendingUsers.clear();
      _pendingUsers.addAll(
        resp.data.map((e) => SnAccount.fromJson(e)).toList().cast<SnAccount>(),
      );
    });
  }

  bool _checkSelected(SnAccount item) {
    return _selectedUsers.any((x) => x.id == item.id);
  }

  @override
  void initState() {
    super.initState();
    _getFriends();
    _revertSelectedUsers();
  }

  @override
  void dispose() {
    super.dispose();
    _probeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.85,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Symbols.group, size: 24),
              const Gap(16),
              Text(widget.title, style: Theme.of(context).textTheme.titleLarge),
            ],
          ).padding(horizontal: 20, top: 16, bottom: 12),
          Container(
            color: Theme.of(context).colorScheme.secondaryContainer,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: TextField(
              controller: _probeController,
              decoration: InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
                hintText: 'search'.tr(),
              ),
              onSubmitted: (_) {
                _searchAccount();
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _pendingUsers.isEmpty
                  ? _relativeUsers.length
                  : _pendingUsers.length,
              itemBuilder: (context, index) {
                var user = _pendingUsers.isEmpty
                    ? _relativeUsers[index]
                    : _pendingUsers[index];
                return ListTile(
                  title: Text(user.nick),
                  subtitle: Text(user.name),
                  leading: AccountImage(content: user.avatar),
                  trailing: widget.trailingBuilder != null
                      ? widget.trailingBuilder!(user)
                      : _checkSelected(user)
                          ? const Icon(Icons.check)
                          : null,
                  onTap: user.id == _accountId
                      ? null
                      : () {
                          if (widget.onMultipleSelect == null) {
                            Navigator.pop(context, user);
                            return;
                          }

                          setState(() {
                            final idx = _selectedUsers
                                .indexWhere((x) => x.id == user.id);
                            if (idx != -1) {
                              _selectedUsers.removeAt(idx);
                            } else {
                              _selectedUsers.add(user);
                            }
                          });
                          widget.onMultipleSelect!(_selectedUsers);
                        },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
