import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:surface/widgets/navigation/app_scaffold.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: Text("screenAccount").tr(),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('screenAuthLogin').tr(),
            subtitle: Text('screenAuthLoginSubtitle').tr(),
            contentPadding: const EdgeInsets.symmetric(horizontal: 24),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              GoRouter.of(context).pushNamed('authLogin');
            },
          ),
          ListTile(
            title: Text('screenAuthRegister').tr(),
            subtitle: Text('screenAuthRegisterSubtitle').tr(),
            contentPadding: const EdgeInsets.symmetric(horizontal: 24),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              GoRouter.of(context).pushNamed('authRegister');
            },
          )
        ],
      ),
    );
  }
}
