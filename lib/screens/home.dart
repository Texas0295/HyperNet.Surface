import 'package:easy_localization/easy_localization.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("screenHome").tr(),
      ),
      body: Column(
        children: [
          MaterialBanner(
            leading: const Icon(Symbols.construction),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('nextVersionAlert').tr().bold(),
                Text('nextVersionNotice').tr(),
              ],
            ).padding(vertical: 16),
            actions: [
              const SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}
