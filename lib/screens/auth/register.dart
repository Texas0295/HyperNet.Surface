import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:surface/providers/sn_network.dart';
import 'package:surface/widgets/dialog.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _performAction(BuildContext context) async {
    final email = _emailController.value.text;
    final username = _usernameController.value.text;
    final nickname = _nicknameController.value.text;
    final password = _passwordController.value.text;
    if (email.isEmpty ||
        username.isEmpty ||
        nickname.isEmpty ||
        password.isEmpty) {
      return;
    }

    try {
      final sn = context.read<SnNetworkProvider>();
      await sn.client.post('/cgi/id/users', data: {
        'name': username,
        'nick': nickname,
        'email': email,
        'password': password,
      });

      if (!mounted) return;

      // TODO make celebration here
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } catch (err) {
      context.showErrorDialog(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 280),
      child: StyledWidget(
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: CircleAvatar(
                  radius: 26,
                  child: const Icon(
                    Symbols.person_add,
                    size: 28,
                  ),
                ).padding(bottom: 8),
              ),
              Text(
                'screenAuthRegister',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                ),
              ).tr().padding(left: 4, bottom: 16),
              Column(
                children: [
                  TextField(
                    autocorrect: false,
                    enableSuggestions: false,
                    controller: _usernameController,
                    autofillHints: const [AutofillHints.username],
                    decoration: InputDecoration(
                      isDense: true,
                      border: const UnderlineInputBorder(),
                      labelText: 'fieldUsername'.tr(),
                    ),
                    onTapOutside: (_) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                  ),
                  const Gap(12),
                  TextField(
                    autocorrect: false,
                    enableSuggestions: false,
                    controller: _nicknameController,
                    autofillHints: const [AutofillHints.nickname],
                    decoration: InputDecoration(
                      isDense: true,
                      border: const UnderlineInputBorder(),
                      labelText: 'fieldNickname'.tr(),
                    ),
                    onTapOutside: (_) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                  ),
                  const Gap(12),
                  TextField(
                    autocorrect: false,
                    enableSuggestions: false,
                    controller: _emailController,
                    autofillHints: const [AutofillHints.email],
                    decoration: InputDecoration(
                      isDense: true,
                      border: const UnderlineInputBorder(),
                      labelText: 'fieldEmail'.tr(),
                    ),
                    onTapOutside: (_) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                  ),
                  const Gap(12),
                  TextField(
                    obscureText: true,
                    autocorrect: false,
                    enableSuggestions: false,
                    autofillHints: const [AutofillHints.password],
                    controller: _passwordController,
                    decoration: InputDecoration(
                      isDense: true,
                      border: const UnderlineInputBorder(),
                      labelText: 'fieldPassword'.tr(),
                    ),
                    onTapOutside: (_) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                    onSubmitted: (_) => _performAction(context),
                  ),
                ],
              ).padding(horizontal: 7),
              const Gap(16),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => _performAction(context),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('next').tr(),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ).padding(all: 24).center(),
    );
  }
}
