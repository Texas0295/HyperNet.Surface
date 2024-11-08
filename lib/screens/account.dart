import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
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
        title: Text("screenHome").tr(),
      ),
    );
  }
}
