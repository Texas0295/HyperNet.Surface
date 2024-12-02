import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:surface/providers/sn_network.dart';
import 'package:surface/types/account.dart';
import 'package:surface/widgets/account/account_image.dart';
import 'package:surface/widgets/dialog.dart';
import 'package:surface/widgets/universal_image.dart';

const Map<String, (String, IconData)> kBadgesMeta = {
  'company.staff': (
    'badgeCompanyStaff',
    Symbols.tools_wrench,
  ),
  'site.migration': (
    'badgeSiteMigration',
    Symbols.flag,
  ),
};

class UserScreen extends StatefulWidget {
  final String name;
  const UserScreen({super.key, required this.name});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen>
    with SingleTickerProviderStateMixin {
  late final ScrollController _scrollController = ScrollController();

  SnAccount? _account;

  Future<void> _fetchAccount() async {
    try {
      final sn = context.read<SnNetworkProvider>();
      final resp = await sn.client.get('/cgi/id/users/${widget.name}');
      if (!mounted) return;
      _account = SnAccount.fromJson(resp.data);
    } catch (err) {
      if (!mounted) return;
      context.showErrorDialog(err).then((_) {
        if (mounted) Navigator.pop(context);
      });
    } finally {
      setState(() {});
    }
  }

  double _appBarBlur = 0.0;

  late final _appBarWidth = MediaQuery.of(context).size.width;
  late final _appBarHeight =
      (_appBarWidth * kBannerAspectRatio).roundToDouble();

  void _updateAppBarBlur() {
    if (_scrollController.offset > _appBarHeight) return;
    setState(() {
      _appBarBlur =
          (_scrollController.offset / _appBarHeight * 10).clamp(0.0, 10.0);
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchAccount().then((_) {});
    _scrollController.addListener(_updateAppBarBlur);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateAppBarBlur);
    _scrollController.dispose();
    super.dispose();
  }

  static const kBannerAspectRatio = 7 / 16;

  @override
  Widget build(BuildContext context) {
    final imageHeight = _appBarHeight + kToolbarHeight + 8;

    const labelShadows = <Shadow>[
      Shadow(
        offset: Offset(1, 1),
        blurRadius: 5.0,
        color: Color.fromARGB(255, 0, 0, 0),
      ),
    ];

    final sn = context.read<SnNetworkProvider>();

    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: _appBarHeight,
              title: _account == null
                  ? Text('loading').tr()
                  : RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                          text: _account!.nick,
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: Colors.white,
                                    shadows: labelShadows,
                                  ),
                        ),
                        const TextSpan(text: '\n'),
                        TextSpan(
                          text: '@${_account!.name}',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: Colors.white,
                                    shadows: labelShadows,
                                  ),
                        ),
                      ]),
                    ),
              pinned: true,
              flexibleSpace: _account != null
                  ? Stack(
                      fit: StackFit.expand,
                      children: [
                        UniversalImage(
                          sn.getAttachmentUrl(_account!.banner),
                          fit: BoxFit.cover,
                          height: imageHeight,
                          width: _appBarWidth,
                          cacheHeight: imageHeight,
                          cacheWidth: _appBarWidth,
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          height: 56 + MediaQuery.of(context).padding.top,
                          child: ClipRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: _appBarBlur,
                                sigmaY: _appBarBlur,
                              ),
                              child: Container(
                                color: Colors.black.withOpacity(
                                  clampDouble(_appBarBlur * 0.1, 0, 0.5),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : null,
            ),
          ];
        },
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    AccountImage(
                      content: _account!.avatar,
                      radius: 28,
                    ),
                    const Gap(16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _account!.nick,
                            style: Theme.of(context).textTheme.titleMedium,
                          ).bold(),
                          Text('@${_account!.name}').fontSize(13),
                        ],
                      ),
                    ),
                  ],
                ).padding(right: 8),
                const Gap(12),
                Text(_account!.description).padding(horizontal: 8),
                const Gap(12),
                Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Symbols.calendar_add_on),
                        const Gap(8),
                        Text('publisherJoinedAt').tr(args: [
                          DateFormat('y/M/d').format(_account!.createdAt)
                        ]),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Symbols.cake),
                        const Gap(8),
                        Text('accountBirthday').tr(args: [
                          _account!.profile?.birthday == null
                              ? 'unknown'.tr()
                              : DateFormat('M/d')
                                  .format(_account!.profile!.birthday!)
                        ]),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Symbols.identity_platform),
                        const Gap(8),
                        Text(
                          '#${_account!.id.toString().padLeft(8, '0')}',
                          style: GoogleFonts.robotoMono(),
                        ).opacity(0.8),
                      ],
                    ),
                  ],
                ).padding(horizontal: 8),
              ],
            ).padding(all: 16),
            const Divider(),
            const Gap(12),
            Text('accountBadge')
                .bold()
                .fontSize(17)
                .tr()
                .padding(horizontal: 20, bottom: 4),
            SizedBox(
              height: 64,
              width: double.infinity,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 8),
                scrollDirection: Axis.horizontal,
                children: [
                  for (final badge in _account?.badges ?? [])
                    SizedBox(
                      width: 280,
                      child: Card(
                        child: ListTile(
                          leading: Icon(
                            kBadgesMeta[badge.type]?.$2 ??
                                Symbols.question_mark,
                          ),
                          title: Text(
                            kBadgesMeta[badge.type]?.$1 ?? 'unknown',
                          ).tr(),
                        ),
                      ),
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
