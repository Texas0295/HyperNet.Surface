import 'dart:io';
import 'dart:ui';

import 'package:croppy/croppy.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:path/path.dart' show basename;
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:surface/providers/sn_attachment.dart';
import 'package:surface/providers/sn_network.dart';
import 'package:surface/providers/userinfo.dart';
import 'package:surface/widgets/account/account_image.dart';
import 'package:surface/widgets/dialog.dart';
import 'package:surface/widgets/loading_indicator.dart';
import 'package:surface/widgets/universal_image.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final _imagePicker = ImagePicker();

  final _usernameController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _birthdayController = TextEditingController();

  String? _avatar;
  String? _banner;
  DateTime? _birthday;

  bool _isBusy = false;

  static const _kDateFormat = 'y/M/d';

  void _syncWidget() async {
    final ua = context.read<UserProvider>();
    final prof = ua.user!;
    _usernameController.text = prof.name;
    _nicknameController.text = prof.nick;
    _descriptionController.text = prof.description;
    _firstNameController.text = prof.profile!.firstName;
    _lastNameController.text = prof.profile!.lastName;
    _avatar = prof.avatar;
    _banner = prof.banner;
    if (prof.profile!.birthday != null) {
      _birthdayController.text = DateFormat(_kDateFormat).format(
        prof.profile!.birthday!.toLocal(),
      );
    }
  }

  void _selectBirthday() async {
    await showCupertinoModalPopup<DateTime?>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: Theme.of(context).colorScheme.surface,
        child: SafeArea(
          top: false,
          child: CupertinoDatePicker(
            initialDateTime: _birthday?.toLocal(),
            mode: CupertinoDatePickerMode.date,
            use24hFormat: true,
            onDateTimeChanged: (DateTime newDate) {
              setState(() {
                _birthday = newDate;
                _birthdayController.text =
                    DateFormat(_kDateFormat).format(_birthday!);
              });
            },
          ),
        ),
      ),
    );
  }

  Future<void> _updateImage(String place) async {
    final image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    if (!mounted) return;

    final ImageProvider imageProvider =
        kIsWeb ? NetworkImage(image.path) : FileImage(File(image.path));
    final aspectRatios = place == 'banner'
        ? [CropAspectRatio(width: 16, height: 7)]
        : [CropAspectRatio(width: 1, height: 1)];
    final result = (!kIsWeb && (Platform.isIOS || Platform.isMacOS))
        ? await showCupertinoImageCropper(
            // ignore: use_build_context_synchronously
            context,
            allowedAspectRatios: aspectRatios,
            imageProvider: imageProvider,
          )
        : await showMaterialImageCropper(
            // ignore: use_build_context_synchronously
            context,
            allowedAspectRatios: aspectRatios,
            imageProvider: imageProvider,
          );

    if (result == null) return;

    if (!mounted) return;
    final attach = context.read<SnAttachmentProvider>();

    setState(() => _isBusy = true);

    final rawBytes =
        (await result.uiImage.toByteData(format: ImageByteFormat.png))!
            .buffer
            .asUint8List();

    try {
      final attachment = await attach.directUploadOne(
        rawBytes,
        basename(image.path),
        'avatar',
        null,
        mimetype: 'image/png',
      );

      if (!mounted) return;
      final sn = context.read<SnNetworkProvider>();
      await sn.client.put(
        '/cgi/id/users/me/$place',
        data: {'attachment': attachment.rid},
      );

      if (!mounted) return;
      final ua = context.read<UserProvider>();
      await ua.refreshUser();

      if (!mounted) return;
      context.showSnackbar('accountProfileEditApplied'.tr());
      _syncWidget();
    } catch (err) {
      if (!mounted) return;
      context.showErrorDialog(err);
    } finally {
      setState(() => _isBusy = false);
    }
  }

  void _updateUserInfo() async {
    setState(() => _isBusy = true);

    final sn = context.read<SnNetworkProvider>();

    try {
      await sn.client.put(
        '/cgi/id/users/me',
        data: {
          'nick': _nicknameController.value.text,
          'description': _descriptionController.value.text,
          'first_name': _firstNameController.value.text,
          'last_name': _lastNameController.value.text,
          'birthday': _birthday?.toUtc().toIso8601String(),
        },
      );

      if (!mounted) return;
      final ua = context.read<UserProvider>();
      await ua.refreshUser();

      if (!mounted) return;
      context.showSnackbar('accountProfileEditApplied'.tr());
      _syncWidget();
    } catch (err) {
      context.showErrorDialog(err);
    } finally {
      setState(() => _isBusy = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _syncWidget();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _nicknameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _descriptionController.dispose();
    _birthdayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double padding = 24;

    final sn = context.read<SnNetworkProvider>();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LoadingIndicator(isActive: _isBusy),
          const Gap(24),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Material(
                elevation: 0,
                child: InkWell(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Container(
                        color:
                            Theme.of(context).colorScheme.surfaceContainerHigh,
                        child: _banner != null
                            ? UniversalImage(
                                sn.getAttachmentUrl(_banner!),
                                fit: BoxFit.cover,
                              )
                            : const SizedBox.shrink(),
                      ),
                    ),
                  ),
                  onTap: () {
                    _updateImage('banner');
                  },
                ),
              ),
              Positioned(
                bottom: -28,
                left: 16,
                child: Material(
                  elevation: 2,
                  borderRadius: const BorderRadius.all(Radius.circular(40)),
                  child: InkWell(
                    child: AccountImage(content: _avatar, radius: 40),
                    onTap: () {
                      _updateImage('avatar');
                    },
                  ),
                ),
              ),
            ],
          ).padding(horizontal: padding),
          const Gap(8 + 28),
          Column(
            children: [
              TextField(
                readOnly: true,
                controller: _usernameController,
                decoration: InputDecoration(
                  border: const UnderlineInputBorder(),
                  labelText: 'fieldUsername'.tr(),
                  helperText: 'fieldUsernameCannotEditHint'.tr(),
                ),
              ),
              const Gap(4),
              TextField(
                controller: _nicknameController,
                decoration: InputDecoration(
                  border: const UnderlineInputBorder(),
                  labelText: 'fieldNickname'.tr(),
                ),
              ),
              const Gap(4),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: TextField(
                      controller: _firstNameController,
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        labelText: 'fieldFirstName'.tr(),
                      ),
                    ),
                  ),
                  const Gap(8),
                  Flexible(
                    flex: 1,
                    child: TextField(
                      controller: _lastNameController,
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        labelText: 'fieldLastName'.tr(),
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(4),
              TextField(
                controller: _descriptionController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                minLines: 3,
                decoration: InputDecoration(
                  border: const UnderlineInputBorder(),
                  labelText: 'fieldDescription'.tr(),
                ),
              ),
              const Gap(4),
              TextField(
                controller: _birthdayController,
                readOnly: true,
                decoration: InputDecoration(
                  border: const UnderlineInputBorder(),
                  labelText: 'fieldBirthday'.tr(),
                ),
                onTap: () => _selectBirthday(),
              ),
            ],
          ).padding(horizontal: padding + 8),
          const Gap(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton.icon(
                onPressed: _isBusy ? null : _updateUserInfo,
                icon: const Icon(Symbols.save),
                label: Text('apply').tr(),
              ),
            ],
          ).padding(horizontal: padding),
        ],
      ),
    );
  }
}
