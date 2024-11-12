import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:surface/providers/sn_network.dart';
import 'package:surface/types/post.dart';
import 'package:surface/types/reaction.dart';
import 'package:surface/widgets/dialog.dart';

class PostReactionPopup extends StatefulWidget {
  final SnPost data;
  final Function(Map<String, int> value, bool isPositive, int delta)? onChanged;
  const PostReactionPopup({super.key, required this.data, this.onChanged});

  @override
  State<PostReactionPopup> createState() => _PostReactionPopupState();
}

class _PostReactionPopupState extends State<PostReactionPopup> {
  bool _isSubmitting = false;
  late Map<String, int> _reactions;

  Future<void> _reactPost(String symbol, int attitude) async {
    if (_isSubmitting) return;

    final sn = context.read<SnNetworkProvider>();

    try {
      setState(() => _isSubmitting = true);
      final resp = await sn.client.post(
        '/cgi/co/posts/${widget.data.id}/react',
        data: {
          'symbol': symbol,
          'attitude': attitude,
        },
      );
      if (resp.statusCode == 201) {
        _reactions[symbol] = (_reactions[symbol] ?? 0) + 1;
        // ignore: use_build_context_synchronously
        if (context.mounted) context.showSnackbar('postReactCompleted'.tr());
        if (widget.onChanged != null) {
          widget.onChanged!(
            _reactions,
            kTemplateReactions[symbol]!.attitude == 1,
            1,
          );
        }
      } else if (resp.statusCode == 204) {
        _reactions[symbol] = (_reactions[symbol] ?? 0) - 1;
        // ignore: use_build_context_synchronously
        if (context.mounted) context.showSnackbar('postReactUncompleted'.tr());
        if (widget.onChanged != null) {
          widget.onChanged!(
            _reactions,
            kTemplateReactions[symbol]!.attitude == 1,
            -1,
          );
        }
      }
    } catch (err) {
      // ignore: use_build_context_synchronously
      if (context.mounted) context.showErrorDialog(err);
    } finally {
      setState(() => _isSubmitting = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _reactions = Map.from(widget.data.metric.reactionList);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Symbols.mood, size: 24),
              const Gap(16),
              Text('postReactions')
                  .tr()
                  .textStyle(Theme.of(context).textTheme.titleLarge!),
            ],
          ).padding(horizontal: 20, top: 16, bottom: 12),
          Expanded(
            child: GridView.count(
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
              crossAxisCount: 4,
              children: kTemplateReactions.entries.map((e) {
                return InkWell(
                  onTap: () {
                    if (widget.onChanged == null) return;
                    _reactPost(e.key, e.value.attitude).then((_) {
                      if (context.mounted) Navigator.pop(context);
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(e.value.icon).fontSize(40),
                      Text(
                        e.key,
                        style: const TextStyle(fontFamily: 'monospace'),
                      ),
                      const Gap(6),
                      Text(
                        'x${_reactions[e.key]?.toString() ?? '0'}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
