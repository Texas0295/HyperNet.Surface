import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import 'package:surface/providers/sn_network.dart';
import 'package:surface/types/poll.dart';
import 'package:surface/widgets/dialog.dart';
import 'package:uuid/uuid.dart';

class PollEditorDialog extends StatefulWidget {
  final SnPoll? poll;

  const PollEditorDialog({super.key, this.poll});

  @override
  State<PollEditorDialog> createState() => _PollEditorDialogState();
}

class _PollEditorDialogState extends State<PollEditorDialog> {
  final TextEditingController _linkController = TextEditingController();
  final List<SnPollOption> _pollOptions = List.empty(growable: true);

  bool _isBusy = false;

  Future<void> _fetchPoll() async {
    if (_linkController.text.isEmpty) return;
    try {
      setState(() => _isBusy = true);
      final sn = context.read<SnNetworkProvider>();
      final resp = await sn.client.get('/cgi/co/polls/${_linkController.text}');
      final out = SnPoll.fromJson(resp.data);
      if (!mounted) return;
      Navigator.pop(context, out);
    } catch (err) {
      if (!mounted) return;
      context.showErrorDialog(err);
    } finally {
      setState(() => _isBusy = false);
    }
  }

  Future<void> _applyPost() async {
    try {
      setState(() => _isBusy = true);
      final sn = context.read<SnNetworkProvider>();
      final resp = widget.poll == null
          ? await sn.client.post('/cgi/co/polls', data: {
              'options': _pollOptions.where((ele) => ele.name.isNotEmpty).toList(),
            })
          : await sn.client.put('/cgi/co/polls/${widget.poll!.id}', data: {
              'options': _pollOptions.where((ele) => ele.name.isNotEmpty).toList(),
            });
      final out = SnPoll.fromJson(resp.data);
      if (!mounted) return;
      Navigator.pop(context, out);
    } catch (err) {
      if (!mounted) return;
      context.showErrorDialog(err);
    } finally {
      setState(() => _isBusy = false);
    }
  }

  Future<void> _deletePoll() async {
    final confirm = await context.showConfirmDialog(
      'pollEditorDelete'.tr(),
      'pollEditorDeleteDescription'.tr(),
    );
    if (!confirm) return;
    if (!mounted) return;

    try {
      setState(() => _isBusy = true);
      final sn = context.read<SnNetworkProvider>();
      await sn.client.delete('/cgi/co/polls/${widget.poll!.id}');
      if (!mounted) return;
      Navigator.pop(context, false);
    } catch (err) {
      if (!mounted) return;
      context.showErrorDialog(err);
    } finally {
      setState(() => _isBusy = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _pollOptions.addAll(widget.poll?.options ?? []);
  }

  @override
  void dispose() {
    _linkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.poll == null ? 'pollEditorNew' : 'pollEditorEdit').tr(),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 16,
        children: [
          if (widget.poll == null)
            TextField(
              controller: _linkController,
              decoration: InputDecoration(
                isDense: true,
                labelText: 'pollLinkExisting'.tr(),
                prefixText: '#',
                suffixIcon: IconButton(
                  visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                  onPressed: _isBusy ? null : () => _fetchPoll(),
                  icon: const Icon(Icons.keyboard_arrow_right),
                ),
                border: const OutlineInputBorder(),
              ),
              onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
            ),
          Card(
            margin: EdgeInsets.zero,
            child: Column(
              children: [
                for (int i = 0; i < _pollOptions.length; i++)
                  ListTile(
                    leading: const Icon(Symbols.circle),
                    title: TextFormField(
                      decoration: InputDecoration.collapsed(
                        hintText: 'pollOptionName'.tr(),
                      ),
                      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
                      initialValue: _pollOptions[i].name,
                      onChanged: (value) {
                        // Looks like we don't need set state here cuz it got internal updated.
                        _pollOptions[i] = _pollOptions[i].copyWith(name: value);
                      },
                    ),
                    trailing: IconButton(
                      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () {
                        setState(() => _pollOptions.removeAt(i));
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ),
                ListTile(
                  leading: const Icon(Symbols.add),
                  title: Text('pollOptionAdd').tr(),
                  onTap: () {
                    setState(
                      () => _pollOptions.add(
                        SnPollOption(id: const Uuid().v4(), icon: '', name: '', description: ''),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          if (widget.poll != null)
            Card(
              margin: EdgeInsets.zero,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Symbols.delete),
                    trailing: const Icon(Symbols.chevron_right),
                    title: Text('pollEditorDelete').tr(),
                    onTap: _isBusy ? null : () => _deletePoll(),
                  ),
                  ListTile(
                    leading: const Icon(Symbols.link_off),
                    trailing: const Icon(Symbols.chevron_right),
                    title: Text('pollEditorUnlink').tr(),
                    onTap: _isBusy ? null : () => Navigator.pop(context, false),
                  ),
                ],
              ),
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _isBusy ? null : () => Navigator.pop(context),
          child: Text('cancel'.tr()),
        ),
        TextButton(
          onPressed: _isBusy ? null : () => _applyPost(),
          child: Text('dialogConfirm'.tr()),
        ),
      ],
    );
  }
}
