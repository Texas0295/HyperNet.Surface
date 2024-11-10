import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:surface/providers/sn_network.dart';
import 'package:surface/providers/userinfo.dart';
import 'package:surface/widgets/account/account_image.dart';
import 'package:surface/widgets/dialog.dart';
import 'package:surface/widgets/navigation/app_scaffold.dart';

class AccountPublisherNewScreen extends StatefulWidget {
  const AccountPublisherNewScreen({super.key});

  @override
  State<AccountPublisherNewScreen> createState() =>
      _AccountPublisherNewScreenState();
}

class _AccountPublisherNewScreenState extends State<AccountPublisherNewScreen> {
  String mode = 'personal';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: SegmentedButton<String>(
                segments: const <ButtonSegment<String>>[
                  ButtonSegment<String>(
                      value: 'personal',
                      label: Text('Personal'),
                      icon: Icon(Symbols.account_box)),
                  ButtonSegment<String>(
                      value: 'organization',
                      label: Text('Organization'),
                      icon: Icon(Symbols.group)),
                ],
                selected: {mode},
                onSelectionChanged: (Set<String> newSelection) {
                  setState(() => mode = newSelection.first);
                },
              ),
            ),
            switch (mode) {
              'personal' => const _PublisherNewPersonal(),
              _ => const Placeholder(),
            },
          ],
        ).padding(horizontal: 16, vertical: 12),
      ),
    );
  }
}

class _PublisherNewPersonal extends StatefulWidget {
  const _PublisherNewPersonal();

  @override
  State<_PublisherNewPersonal> createState() => _PublisherNewPersonalState();
}

class _PublisherNewPersonalState extends State<_PublisherNewPersonal> {
  bool _isBusy = false;

  void _performAction() async {
    final sn = context.read<SnNetworkProvider>();
    final ua = context.read<UserProvider>();
    if (!ua.isAuthorized) return;

    setState(() => _isBusy = true);

    try {
      await sn.client.post('/cgi/co/publishers/personal');
      Navigator.pop(context, true);
    } catch (err) {
      context.showErrorDialog(err);
    } finally {
      setState(() => _isBusy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ua = context.watch<UserProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('preview')
            .tr()
            .textStyle(Theme.of(context).textTheme.titleMedium!)
            .padding(horizontal: 16, vertical: 4),
        Card(
          child: SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                AccountImage(content: ua.user!.avatar, radius: 24),
                const Gap(16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(ua.user!.nick)
                        .textStyle(Theme.of(context).textTheme.titleLarge!),
                    const Gap(4),
                    Text('@${ua.user!.name}')
                        .textStyle(Theme.of(context).textTheme.bodySmall!),
                  ],
                ),
              ],
            ),
          ).padding(all: 16),
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _isBusy ? null : _performAction,
            icon: const Icon(Symbols.add),
            label: Text('create').tr(),
          ),
        ).padding(horizontal: 2),
      ],
    );
  }
}
