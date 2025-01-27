import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:surface/providers/sn_network.dart';
import 'package:surface/types/auth.dart';
import 'package:surface/widgets/dialog.dart';
import 'package:surface/widgets/loading_indicator.dart';
import 'package:surface/widgets/navigation/app_scaffold.dart';

final Map<int, (String, String, IconData)> _kFactorTypes = {
  0: ('authFactorPassword', 'authFactorPasswordDescription', Symbols.password),
  1: ('authFactorEmail', 'authFactorEmailDescription', Symbols.email),
  2: ('authFactorTOTP', 'authFactorTOTPDescription', Symbols.timer),
  3: ('authFactorInAppNotify', 'authFactorInAppNotifyDescription', Symbols.notifications_active),
};

class FactorSettingsScreen extends StatefulWidget {
  const FactorSettingsScreen({super.key});

  @override
  State<FactorSettingsScreen> createState() => _FactorSettingsScreenState();
}

class _FactorSettingsScreenState extends State<FactorSettingsScreen> {
  List<SnAuthFactor>? _factors;

  Future<void> _fetchFactors() async {
    try {
      final sn = context.read<SnNetworkProvider>();
      final resp = await sn.client.get('/cgi/id/users/me/factors');
      _factors = List<SnAuthFactor>.from(
        resp.data?.map((e) => SnAuthFactor.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      );
    } catch (err) {
      if (!mounted) return;
      context.showErrorDialog(err);
    } finally {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchFactors();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        leading: PageBackButton(),
        title: Text('screenFactorSettings').tr(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LoadingIndicator(
            isActive: _factors == null,
          ),
          ListTile(
            title: Text('authFactorAdd').tr(),
            subtitle: Text('authFactorAddSubtitle').tr(),
            contentPadding: const EdgeInsets.symmetric(horizontal: 24),
            leading: const Icon(Symbols.add),
            trailing: const Icon(Symbols.chevron_right),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => _FactorNewDialog(
                  currentlyHave: _factors!,
                ),
              ).then((val) {
                if (val == true) _fetchFactors();
              });
            },
          ),
          const Divider(height: 1),
          Expanded(
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: RefreshIndicator(
                onRefresh: _fetchFactors,
                child: ListView.builder(
                  itemCount: _factors?.length ?? 0,
                  itemBuilder: (context, idx) {
                    final ele = _factors![idx];
                    return ListTile(
                      title: Text(_kFactorTypes[ele.type]!.$1).tr(),
                      subtitle: Text(_kFactorTypes[ele.type]!.$2).tr(),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                      leading: Icon(_kFactorTypes[ele.type]!.$3),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FactorNewDialog extends StatefulWidget {
  final List<SnAuthFactor> currentlyHave;

  const _FactorNewDialog({required this.currentlyHave});

  @override
  State<_FactorNewDialog> createState() => _FactorNewDialogState();
}

class _FactorNewDialogState extends State<_FactorNewDialog> {
  int? _factorType;
  bool _isBusy = false;

  Future<void> _submit() async {
    try {
      setState(() => _isBusy = true);
      final sn = context.read<SnNetworkProvider>();
      final resp = await sn.client.post('/cgi/id/users/me/factors', data: {
        'type': _factorType,
      });
      // TODO show qrcode when creating totp factor
      if (!mounted) return;
      Navigator.of(context).pop(true);
    } catch (err) {
      if (!mounted) return;
      context.showErrorDialog(err);
    } finally {
      setState(() => _isBusy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('authFactorAdd').tr(),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonHideUnderline(
            child: DropdownButton2<int>(
              hint: Text(
                'Select Item',
                style: TextStyle(
                  fontSize: 14,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              value: _factorType,
              items: _kFactorTypes.entries.map(
                (ele) {
                  final contains = widget.currentlyHave.map((ele) => ele.type).contains(ele.key);
                  return DropdownMenuItem<int>(
                    enabled: !contains,
                    value: ele.key,
                    child: Text(
                      ele.value.$1.tr(),
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ).opacity(contains ? 0.75 : 1),
                  );
                },
              ).toList(),
              onChanged: (val) => setState(() {
                _factorType = val;
              }),
              buttonStyleData: ButtonStyleData(
                height: 50,
                padding: const EdgeInsets.only(left: 14, right: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: Theme.of(context).dividerColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _isBusy ? null : () => Navigator.of(context).pop(),
          child: Text('dialogCancel').tr(),
        ),
        TextButton(
          onPressed: _isBusy ? null : () => _submit(),
          child: Text('dialogConfirm').tr(),
        ),
      ],
    );
  }
}
