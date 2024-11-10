import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:surface/providers/theme.dart';
import 'package:surface/theme.dart';
import 'package:surface/widgets/navigation/app_scaffold.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  SharedPreferences? _prefs;
  String _docBasepath = '/';

  @override
  void initState() {
    super.initState();
    getApplicationDocumentsDirectory().then((dir) {
      _docBasepath = dir.path;
      if (mounted) {
        setState(() {});
      }
    });
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        _prefs = prefs;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('settingsAppearance')
                    .bold()
                    .fontSize(17)
                    .tr()
                    .padding(horizontal: 20),
                if (!kIsWeb)
                  ListTile(
                    title: Text('settingsBackgroundImage').tr(),
                    subtitle: Text('settingsBackgroundImageDescription').tr(),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                    leading: const Icon(Symbols.image),
                    trailing: const Icon(Symbols.chevron_right),
                    onTap: () async {
                      final image = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (image == null) return;

                      await File(image.path)
                          .copy('$_docBasepath/app_background_image');

                      setState(() {});
                    },
                  ),
                if (!kIsWeb)
                  FutureBuilder<bool>(
                      future:
                          File('$_docBasepath/app_background_image').exists(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData || !snapshot.data!) {
                          return const SizedBox.shrink();
                        }

                        return ListTile(
                          title: Text('settingsBackgroundImageClear').tr(),
                          subtitle:
                              Text('settingsBackgroundImageClearDescription')
                                  .tr(),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 24),
                          leading: const Icon(Symbols.texture),
                          trailing: const Icon(Symbols.chevron_right),
                          onTap: () {
                            File('$_docBasepath/app_background_image')
                                .deleteSync();
                            setState(() {});
                          },
                        );
                      }),
                if (_prefs != null)
                  CheckboxListTile(
                    title: Text('settingsThemeMaterial3').tr(),
                    subtitle: Text('settingsThemeMaterial3Description').tr(),
                    contentPadding: const EdgeInsets.only(left: 24, right: 17),
                    secondary: const Icon(Symbols.new_releases),
                    value: _prefs!.getBool(kMaterialYouToggleStoreKey) ?? false,
                    onChanged: (value) {
                      setState(() {
                        _prefs!.setBool(
                          kMaterialYouToggleStoreKey,
                          value ?? false,
                        );
                      });
                      final th = context.watch<ThemeProvider>();
                      th.reloadTheme(useMaterial3: value ?? false);
                    },
                  ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('settingsNetwork')
                    .bold()
                    .fontSize(17)
                    .tr()
                    .padding(horizontal: 20),
              ],
            ),
          ].expand((ele) => [ele, const Gap(16)]).toList(),
        ).padding(vertical: 20),
      ),
    );
  }
}
