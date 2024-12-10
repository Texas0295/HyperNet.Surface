import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:croppy/croppy.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:relative_time/relative_time.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:surface/firebase_options.dart';
import 'package:surface/providers/channel.dart';
import 'package:surface/providers/chat_call.dart';
import 'package:surface/providers/navigation.dart';
import 'package:surface/providers/notification.dart';
import 'package:surface/providers/post.dart';
import 'package:surface/providers/relationship.dart';
import 'package:surface/providers/sn_attachment.dart';
import 'package:surface/providers/sn_network.dart';
import 'package:surface/providers/theme.dart';
import 'package:surface/providers/user_directory.dart';
import 'package:surface/providers/userinfo.dart';
import 'package:surface/providers/websocket.dart';
import 'package:surface/router.dart';
import 'package:surface/types/chat.dart';
import 'package:surface/types/realm.dart';
import 'package:flutter_web_plugins/url_strategy.dart' show usePathUrlStrategy;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(SnChannelImplAdapter());
  Hive.registerAdapter(SnRealmImplAdapter());
  Hive.registerAdapter(SnChannelMemberImplAdapter());
  Hive.registerAdapter(SnChatMessageImplAdapter());

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  GoRouter.optionURLReflectsImperativeAPIs = true;
  usePathUrlStrategy();

  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    doWhenWindowReady(() {
      appWindow.minSize = Size(480, 640);
      appWindow.size = Size(1280, 720);
      appWindow.alignment = Alignment.center;
      appWindow.show();
    });
  }

  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://c218d44126d59d69301e730498494def@o4506965897117696.ingest.us.sentry.io/4508346768228352';
      options.tracesSampleRate = 1.0;
      options.profilesSampleRate = 1.0;
    },
    appRunner: () => runApp(const SolianApp()),
  );
}

class SolianApp extends StatelessWidget {
  const SolianApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBreakpoints.builder(
      child: EasyLocalization(
        path: 'assets/translations',
        supportedLocales: [Locale('en', 'US'), Locale('zh', 'CN')],
        fallbackLocale: Locale('en', 'US'),
        useFallbackTranslations: true,
        useOnlyLangCode: true,
        assetLoader: JsonAssetLoader(),
        child: MultiProvider(
          providers: [
            // Display layer
            ChangeNotifierProvider(create: (_) => ThemeProvider()),
            ChangeNotifierProvider(create: (ctx) => NavigationProvider()),

            // Data layer
            Provider(create: (_) => SnNetworkProvider()),
            Provider(create: (ctx) => UserDirectoryProvider(ctx)),
            Provider(create: (ctx) => SnAttachmentProvider(ctx)),
            Provider(create: (ctx) => SnPostContentProvider(ctx)),
            Provider(create: (ctx) => SnRelationshipProvider(ctx)),
            ChangeNotifierProvider(create: (ctx) => UserProvider(ctx)),
            ChangeNotifierProvider(create: (ctx) => WebSocketProvider(ctx)),
            ChangeNotifierProvider(create: (ctx) => NotificationProvider(ctx)),
            ChangeNotifierProvider(create: (ctx) => ChatChannelProvider(ctx)),
            ChangeNotifierProvider(create: (ctx) => ChatCallProvider(ctx)),
          ],
          child: AppMainContent(),
        ),
      ),
      breakpoints: [
        const Breakpoint(start: 0, end: 450, name: MOBILE),
        const Breakpoint(start: 451, end: 800, name: TABLET),
        const Breakpoint(start: 801, end: 1920, name: DESKTOP),
      ],
    );
  }
}

class AppMainContent extends StatelessWidget {
  const AppMainContent({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<NavigationProvider>();
    context.read<WebSocketProvider>();
    context.read<ChatChannelProvider>();
    context.read<NotificationProvider>();

    final th = context.watch<ThemeProvider>();

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: th.theme?.light,
      darkTheme: th.theme?.dark,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: [
        CroppyLocalizations.delegate,
        RelativeTimeLocalizations.delegate,
        ...context.localizationDelegates,
      ],
      routerConfig: appRouter,
    );
  }
}
