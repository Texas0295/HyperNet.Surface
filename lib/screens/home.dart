import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:surface/widgets/navigation/app_scaffold.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: Text("screenHome").tr(),
      ),
    );
  }
}
