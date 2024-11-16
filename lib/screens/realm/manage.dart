import 'dart:io';
import 'dart:ui';

import 'package:croppy/croppy.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
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
import 'package:surface/types/realm.dart';
import 'package:surface/widgets/account/account_image.dart';
import 'package:surface/widgets/dialog.dart';
import 'package:surface/widgets/loading_indicator.dart';
import 'package:surface/widgets/universal_image.dart';
import 'package:uuid/uuid.dart';

class RealmManageScreen extends StatefulWidget {
  final String? editingRealmAlias;
  const RealmManageScreen({super.key, this.editingRealmAlias});

  @override
  State<RealmManageScreen> createState() => _RealmManageScreenState();
}

class _RealmManageScreenState extends State<RealmManageScreen> {
  bool _isBusy = false;

  SnRealm? _editingRealm;

  Future<void> _fetchRealm() async {
    final sn = context.read<SnNetworkProvider>();

    setState(() => _isBusy = true);

    try {
      final resp =
          await sn.client.get('/cgi/id/realms/${widget.editingRealmAlias}');
      final out = SnRealm.fromJson(resp.data);
      _editingRealm = out;
      _avatar = out.avatar;
      _banner = out.banner;
      _aliasController.text = out.alias;
      _nameController.text = out.name;
      _descriptionController.text = out.description;
    } catch (err) {
      // ignore: use_build_context_synchronously
      if (context.mounted) context.showErrorDialog(err);
    } finally {
      setState(() => _isBusy = false);
    }
  }

  String? _avatar;
  String? _banner;

  final _aliasController = TextEditingController();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  final _imagePicker = ImagePicker();

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

      switch (place) {
        case 'avatar':
          _avatar = attachment.rid;
          break;
        case 'banner':
          _banner = attachment.rid;
          break;
      }
    } catch (err) {
      if (!mounted) return;
      context.showErrorDialog(err);
    } finally {
      setState(() => _isBusy = false);
    }
  }

  Future<void> _performAction() async {
    final uuid = const Uuid();
    final payload = {
      'alias': _aliasController.text.isNotEmpty
          ? _aliasController.text.toLowerCase()
          : uuid.v4().replaceAll('-', '').substring(0, 12),
      'name': _nameController.text,
      'description': _descriptionController.text,
      'avatar': _avatar,
      'banner': _banner,
    };

    try {
      final sn = context.read<SnNetworkProvider>();
      final resp = await sn.client.request(
        widget.editingRealmAlias != null
            ? '/cgi/id/realms/${widget.editingRealmAlias}'
            : '/cgi/id/realms',
        data: payload,
        options: Options(
          method: widget.editingRealmAlias != null ? 'PUT' : 'POST',
        ),
      );
      final out = SnRealm.fromJson(resp.data);
      // ignore: use_build_context_synchronously
      if (context.mounted) Navigator.pop(context, out);
    } catch (err) {
      // ignore: use_build_context_synchronously
      if (context.mounted) context.showErrorDialog(err);
    } finally {
      setState(() => _isBusy = false);
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.editingRealmAlias != null) _fetchRealm();
  }

  @override
  void dispose() {
    _aliasController.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sn = context.read<SnNetworkProvider>();

    return Scaffold(
      appBar: AppBar(
        title: widget.editingRealmAlias != null
            ? Text('screenRealmManage').tr()
            : Text('screenRealmNew').tr(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            LoadingIndicator(isActive: _isBusy),
            if (_editingRealm != null)
              MaterialBanner(
                leading: const Icon(Icons.edit),
                leadingPadding: const EdgeInsets.only(left: 10, right: 20),
                dividerColor: Colors.transparent,
                content: Text(
                  'realmEditingNotice'.tr(args: ['#${_editingRealm!.alias}']),
                ),
                actions: [
                  TextButton(
                    child: Text('cancel').tr(),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
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
                          color: Theme.of(context)
                              .colorScheme
                              .surfaceContainerHigh,
                          child: _banner != null
                              ? AutoResizeUniversalImage(
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
                      child: AccountImage(
                        content: _avatar,
                        radius: 40,
                        fallbackWidget: const Icon(Symbols.group, size: 40),
                      ),
                      onTap: () {
                        _updateImage('avatar');
                      },
                    ),
                  ),
                ),
              ],
            ).padding(horizontal: 24),
            const Gap(8 + 28),
            Column(
              children: [
                TextField(
                  controller: _aliasController,
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    labelText: 'fieldRealmAlias'.tr(),
                    helperText: 'fieldRealmAliasHint'.tr(),
                    helperMaxLines: 2,
                  ),
                  onTapOutside: (_) =>
                      FocusManager.instance.primaryFocus?.unfocus(),
                ),
                const Gap(4),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    labelText: 'fieldRealmName'.tr(),
                  ),
                  onTapOutside: (_) =>
                      FocusManager.instance.primaryFocus?.unfocus(),
                ),
                const Gap(4),
                TextField(
                  controller: _descriptionController,
                  maxLines: null,
                  minLines: 3,
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    labelText: 'fieldRealmDescription'.tr(),
                  ),
                  onTapOutside: (_) =>
                      FocusManager.instance.primaryFocus?.unfocus(),
                ),
                const Gap(12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _isBusy ? null : _performAction,
                      icon: const Icon(Symbols.save),
                      label: Text('apply').tr(),
                    ),
                  ],
                ),
              ],
            ).padding(horizontal: 24 + 8),
          ],
        ),
      ),
    );
  }
}
