import 'package:go_router/go_router.dart';
import 'package:surface/screens/account.dart';
import 'package:surface/screens/account/profile_edit.dart';
import 'package:surface/screens/account/publishers/publisher_edit.dart';
import 'package:surface/screens/account/publishers/publisher_new.dart';
import 'package:surface/screens/account/publishers/publishers.dart';
import 'package:surface/screens/auth/login.dart';
import 'package:surface/screens/auth/register.dart';
import 'package:surface/screens/explore.dart';
import 'package:surface/screens/home.dart';
import 'package:surface/screens/post/post_editor.dart';
import 'package:surface/screens/settings.dart';
import 'package:surface/widgets/navigation/app_scaffold.dart';

final appRouter = GoRouter(
  routes: [
    ShellRoute(
      builder: (context, state, child) => AppScaffold(
        body: child,
        showBottomNavigation: true,
      ),
      routes: [
        GoRoute(
          path: '/',
          name: 'home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/posts',
          name: 'explore',
          builder: (context, state) => const ExploreScreen(),
        ),
        GoRoute(
          path: '/account',
          name: 'account',
          builder: (context, state) => const AccountScreen(),
        ),
      ],
    ),
    ShellRoute(
      builder: (context, state, child) => AppScaffold(
        body: child,
      ),
      routes: [
        GoRoute(
          path: '/post/write/:mode',
          name: 'postEditor',
          builder: (context, state) => PostEditorScreen(
            mode: state.pathParameters['mode']!,
            postEditId: int.tryParse(
              state.uri.queryParameters['editing'] ?? '',
            ),
            postReplyId: int.tryParse(
              state.uri.queryParameters['replying'] ?? '',
            ),
            postRepostId: int.tryParse(
              state.uri.queryParameters['reposting'] ?? '',
            ),
          ),
        ),
      ],
    ),
    ShellRoute(
      builder: (context, state, child) => AppScaffold(
        body: child,
        autoImplyAppBar: true,
      ),
      routes: [
        GoRoute(
          path: '/auth/login',
          name: 'authLogin',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/auth/register',
          name: 'authRegister',
          builder: (context, state) => const RegisterScreen(),
        ),
        GoRoute(
          path: '/account/profile/edit',
          name: 'accountProfileEdit',
          builder: (context, state) => const ProfileEditScreen(),
        ),
        GoRoute(
          path: '/account/publishers',
          name: 'accountPublishers',
          builder: (context, state) => const PublisherScreen(),
        ),
        GoRoute(
          path: '/account/publishers/new',
          name: 'accountPublisherNew',
          builder: (context, state) => const AccountPublisherNewScreen(),
        ),
        GoRoute(
          path: '/account/publishers/edit/:name',
          name: 'accountPublisherEdit',
          builder: (context, state) => AccountPublisherEditScreen(
            name: state.pathParameters['name']!,
          ),
        ),
      ],
    ),
    ShellRoute(
      builder: (context, state, child) => AppScaffold(
        body: child,
        autoImplyAppBar: true,
      ),
      routes: [
        GoRoute(
          path: '/settings',
          name: 'settings',
          builder: (context, state) => const SettingsScreen(),
        ),
      ],
    ),
  ],
);
