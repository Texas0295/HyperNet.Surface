import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
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
import 'package:surface/providers/sn_network.dart';
import 'package:surface/providers/theme.dart';
import 'package:surface/theme.dart';
import 'package:surface/widgets/dialog.dart';
import 'package:surface/widgets/navigation/app_scaffold.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  SharedPreferences? _prefs;
  String _docBasepath = '/';

  final TextEditingController _serverUrlController = TextEditingController();

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
        _serverUrlController.text =
            prefs.getString(kNetworkServerStoreKey) ?? kNetworkServerDefault;
      });
    });
  }

  @override
  void dispose() {
    _serverUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sn = context.read<SnNetworkProvider>();

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
                TextField(
                  controller: _serverUrlController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'settingsNetworkServer'.tr(),
                    helperText: 'settingsNetworkServerDescription'.tr(),
                    prefixIcon: const Icon(Symbols.dns),
                    suffixIcon: IconButton(
                      icon: const Icon(Symbols.save),
                      onPressed: () {
                        sn.setBaseUrl(_serverUrlController.text);
                        _prefs?.setString(
                          kNetworkServerStoreKey,
                          _serverUrlController.text,
                        );
                        context.showSnackbar('settingsNetworkServerSaved'.tr());
                        setState(() {});
                      },
                    ),
                  ),
                  onTapOutside: (_) =>
                      FocusManager.instance.primaryFocus?.unfocus(),
                ).padding(horizontal: 16, top: 8, bottom: 4),
                ListTile(
                  title: Text('settingsNetworkServerPreset').tr(),
                  subtitle: Text('settingsNetworkServerPresetDescription').tr(),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                  leading: const Icon(Symbols.lists),
                  trailing: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      items: [
                        ...kNetworkServerDirectory,
                        if (!kNetworkServerDirectory
                            .map((ele) => ele.$2)
                            .contains(_serverUrlController.text))
                          ('Custom', _serverUrlController.text),
                      ]
                          .map(
                            (item) => DropdownMenuItem<String>(
                              value: item.$2,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.$1).fontSize(14),
                                  Text(item.$2, overflow: TextOverflow.ellipsis)
                                      .fontSize(11)
                                ],
                              ),
                            ),
                          )
                          .toList(),
                      value: _serverUrlController.text,
                      onChanged: (String? value) {
                        if (value == null) return;
                        _serverUrlController.text = value;
                        _prefs?.setString(kNetworkServerStoreKey, value);
                        context.showSnackbar('settingsNetworkServerSaved'.tr());
                        setState(() {});
                      },
                      buttonStyleData: const ButtonStyleData(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 5,
                        ),
                        height: 40,
                        width: 140,
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 60,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: Text('settingsNetworkServerReset').tr(),
                  subtitle: Text('settingsNetworkServerResetDescription').tr(),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                  leading: const Icon(Symbols.reset_wrench),
                  trailing: const Icon(Symbols.chevron_right),
                  onTap: () {
                    _serverUrlController.text = kNetworkServerDefault;
                    _prefs?.remove(kNetworkServerStoreKey);
                    context.showSnackbar('settingsNetworkServerSaved'.tr());
                    setState(() {});
                  },
                ),
              ],
            ),
          ].expand((ele) => [ele, const Gap(16)]).toList(),
        ).padding(vertical: 20),
      ),
    );
  }
}
