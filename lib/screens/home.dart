import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:flutter/material.dart';
import 'package:surface/providers/sn_network.dart';
import 'package:surface/providers/userinfo.dart';
import 'package:surface/types/check_in.dart';
import 'package:surface/widgets/dialog.dart';
import 'package:surface/widgets/navigation/app_scaffold.dart';

class HomeScreenDashEntry {
  final String name;
  final Widget child;
  final int rows, cols;

  const HomeScreenDashEntry({
    required this.name,
    required this.child,
    this.rows = 1,
    this.cols = 1,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const List<HomeScreenDashEntry> kCards = [
    HomeScreenDashEntry(
      name: 'dashEntryCheckIn',
      child: _HomeDashCheckInWidget(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ResponsiveBreakpoints.of(context).smallerOrEqualTo(MOBILE)
            ? DrawerButton(onPressed: () {
                globalRootScaffoldKey.currentState?.openDrawer();
              })
            : null,
        title: Text("screenHome").tr(),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Align(
            alignment: constraints.maxWidth > 640
                ? Alignment.center
                : Alignment.topCenter,
            child: Container(
              constraints: const BoxConstraints(maxWidth: 640),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: constraints.maxWidth > 640
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.start,
                  children: [
                    if (constraints.maxWidth <= 640) const Gap(8),
                    Card(
                      child: ListTile(
                        isThreeLine: true,
                        leading: const Icon(Symbols.construction),
                        title: Text('nextVersionAlert').tr(),
                        subtitle: Text('nextVersionNotice').tr(),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                      ),
                    ).padding(horizontal: 8),
                    _HomeDashSpecialDayWidget().padding(top: 8, horizontal: 8),
                    StaggeredGrid.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      children: kCards.map((card) {
                        return StaggeredGridTile.count(
                          crossAxisCellCount: card.cols,
                          mainAxisCellCount: card.rows,
                          child: card.child,
                        );
                      }).toList(),
                    ).padding(horizontal: 8),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _HomeDashSpecialDayWidget extends StatelessWidget {
  const _HomeDashSpecialDayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ua = context.watch<UserProvider>();
    final today = DateTime.now();
    final birthday = ua.user?.profile?.birthday?.toLocal();
    final isBirthday = birthday != null &&
        birthday.day == today.day &&
        birthday.month == today.month;
    return Column(
      children: [
        if (isBirthday)
          Card(
            child: ListTile(
              leading: Text('🎂').fontSize(24),
              title: Text('happyBirthday').tr(args: [ua.user?.nick ?? 'user']),
            ),
          ).padding(bottom: 8),
      ],
    );
  }
}

class _HomeDashCheckInWidget extends StatefulWidget {
  const _HomeDashCheckInWidget({super.key});

  @override
  State<_HomeDashCheckInWidget> createState() => _HomeDashCheckInWidgetState();
}

class _HomeDashCheckInWidgetState extends State<_HomeDashCheckInWidget> {
  bool _isBusy = false;

  SnCheckInRecord? _todayRecord;

  static const int kSuggestionPositiveHintCount = 6;
  static const int kSuggestionNegativeHintCount = 6;

  Future<void> _pullCheckIn() async {
    setState(() => _isBusy = true);
    try {
      final sn = context.read<SnNetworkProvider>();
      final resp = await sn.client.get('/cgi/id/check-in/today');
      _todayRecord = SnCheckInRecord.fromJson(resp.data);
    } finally {
      setState(() => _isBusy = false);
    }
  }

  Future<void> _doCheckIn() async {
    setState(() => _isBusy = true);
    try {
      final sn = context.read<SnNetworkProvider>();
      final resp = await sn.client.post('/cgi/id/check-in');
      _todayRecord = SnCheckInRecord.fromJson(resp.data);
    } catch (err) {
      if (!mounted) return;
      context.showErrorDialog(err);
    } finally {
      setState(() => _isBusy = false);
    }
  }

  Widget _buildDetailChunk(int index, bool positive) {
    final prefix =
        positive ? 'dailyCheckPositiveHint' : 'dailyCheckNegativeHint';
    final mod =
        positive ? kSuggestionPositiveHintCount : kSuggestionNegativeHintCount;
    final pos = math.max(1, _todayRecord!.resultModifiers[index] % mod);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          prefix.tr(args: ['$prefix$pos'.tr()]),
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ).tr(),
        Text(
          '$prefix${pos}Description',
          style: Theme.of(context).textTheme.bodyMedium,
        ).tr(),
      ],
    );
  }

  void _showCheckInDetail() {
    showDialog(
      useRootNavigator: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('dailyCheckDetailTitle'.tr(args: [
            DateFormat('MM/dd').format(DateTime.now().toUtc()),
          ])),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_todayRecord?.resultTier != 0)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailChunk(0, true),
                    const Gap(8),
                    _buildDetailChunk(1, true),
                  ],
                )
              else
                Text(
                  'dailyCheckEverythingIsNegative',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ).tr(),
              const Gap(8),
              if (_todayRecord?.resultTier != 4)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildDetailChunk(2, false),
                    const Gap(8),
                    _buildDetailChunk(3, false),
                  ],
                )
              else
                Text(
                  'dailyCheckEverythingIsPositive',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ).tr(),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('dialogDismiss').tr(),
            )
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    final ua = context.read<UserProvider>();
    Future.delayed(const Duration(milliseconds: 500), () async {
      if (!ua.isAuthorized) return;
      await _pullCheckIn();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: AnimatedSwitcher(
              switchInCurve: Curves.fastOutSlowIn,
              switchOutCurve: Curves.fastOutSlowIn,
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return ScaleTransition(
                  scale: animation,
                  child: child,
                );
              },
              child: _todayRecord == null
                  ? Column(
                      key: Key('daily-check-in-overview-none'),
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'dailyCheckIn',
                          style: Theme.of(context).textTheme.titleLarge,
                        ).tr(),
                        Text(
                          'dailyCheckInNone',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ).tr(),
                      ],
                    )
                  : Column(
                      key: Key('daily-check-in-overview-has'),
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _todayRecord!.symbol,
                          style: GoogleFonts.notoSerifHk(
                            textStyle: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        Text(
                          '+${_todayRecord!.resultExperience} EXP',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                DateFormat('EEE\nMM/dd').format(DateTime.now().toUtc()),
              ).fontSize(13).opacity(0.75),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.surfaceContainer,
                ),
                child: AnimatedSwitcher(
                  switchInCurve: Curves.fastOutSlowIn,
                  switchOutCurve: Curves.fastOutSlowIn,
                  duration: const Duration(milliseconds: 300),
                  child: _todayRecord == null
                      ? IconButton(
                          key: UniqueKey(),
                          tooltip: 'dailyCheckAction'.tr(),
                          icon: const Icon(Symbols.local_fire_department),
                          onPressed: _isBusy ? null : _doCheckIn,
                        )
                      : IconButton(
                          key: UniqueKey(),
                          tooltip: 'dailyCheckDetail'.tr(),
                          icon: const Icon(Symbols.help),
                          onPressed: _showCheckInDetail,
                        ),
                ),
              ),
            ],
          ),
        ],
      ).padding(all: 24),
    );
  }
}

class _HomeDashLinkWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  const _HomeDashLinkWidget({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.surfaceContainer,
              ),
              child: IconButton(
                icon: const Icon(Symbols.arrow_right_alt),
                onPressed: () {},
              ),
            ),
          )
        ],
      ).padding(all: 24),
    );
  }
}
