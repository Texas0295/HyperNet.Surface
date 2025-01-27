import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import 'package:surface/providers/sn_network.dart';
import 'package:surface/widgets/dialog.dart';
import 'package:surface/widgets/navigation/app_scaffold.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        leading: PageBackButton(),
        title: Text('screenAccountSettings').tr(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text('accountProfileEdit').tr(),
              subtitle: Text('accountProfileEditSubtitle').tr(),
              contentPadding: const EdgeInsets.symmetric(horizontal: 24),
              leading: const Icon(Symbols.contact_page),
              trailing: const Icon(Symbols.chevron_right),
              onTap: () {
                GoRouter.of(context).pushNamed('accountProfileEdit');
              },
            ),
            ListTile(
              title: Text('accountDeletion'.tr()),
              subtitle: Text('accountDeletionActionDescription'.tr()),
              contentPadding: const EdgeInsets.symmetric(horizontal: 24),
              leading: const Icon(Symbols.person_cancel),
              trailing: const Icon(Symbols.chevron_right),
              onTap: () {
                context
                    .showConfirmDialog(
                  'accountDeletion'.tr(),
                  'accountDeletionDescription'.tr(),
                )
                    .then((value) {
                  if (!value || !context.mounted) return;
                  final sn = context.read<SnNetworkProvider>();
                  sn.client.post('/cgi/id/users/me/deletion').then((value) {
                    if (context.mounted) {
                      context.showSnackbar('accountDeletionSubmitted'.tr());
                    }
                  }).catchError((err) {
                    if (context.mounted) {
                      context.showErrorDialog(err);
                    }
                  });
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
