import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:surface/screens/account.dart';
import 'package:surface/screens/account/profile_edit.dart';
import 'package:surface/screens/account/publishers/publisher_edit.dart';
import 'package:surface/screens/account/publishers/publisher_new.dart';
import 'package:surface/screens/account/publishers/publishers.dart';
import 'package:surface/screens/album.dart';
import 'package:surface/screens/auth/login.dart';
import 'package:surface/screens/auth/register.dart';
import 'package:surface/screens/chat.dart';
import 'package:surface/screens/chat/manage.dart';
import 'package:surface/screens/chat/room.dart';
import 'package:surface/screens/explore.dart';
import 'package:surface/screens/home.dart';
import 'package:surface/screens/notification.dart';
import 'package:surface/screens/post/post_detail.dart';
import 'package:surface/screens/post/post_editor.dart';
import 'package:surface/screens/post/post_search.dart';
import 'package:surface/screens/realm.dart';
import 'package:surface/screens/realm/manage.dart';
import 'package:surface/screens/settings.dart';
import 'package:surface/types/post.dart';
import 'package:surface/widgets/navigation/app_background.dart';
import 'package:surface/widgets/navigation/app_scaffold.dart';

final _appRoutes = [
  ShellRoute(
    builder: (context, state, child) => AppPageScaffold(
      body: child,
      showAppBar: false,
    ),
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        pageBuilder: (context, state) => NoTransitionPage(
          child: const HomeScreen(),
        ),
      ),
      GoRoute(
        path: '/posts',
        name: 'explore',
        pageBuilder: (context, state) => NoTransitionPage(
          child: const ExploreScreen(),
        ),
        routes: [
          GoRoute(
            path: '/post/write/:mode',
            name: 'postEditor',
            builder: (context, state) => AppBackground(
              isLessOptimization: true,
              child: PostEditorScreen(
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
          ),
          GoRoute(
            path: '/post/search',
            name: 'postSearch',
            builder: (context, state) => const AppBackground(
              child: PostSearchScreen(),
            ),
          ),
          GoRoute(
            path: '/post/:slug',
            name: 'postDetail',
            builder: (context, state) => AppBackground(
              child: PostDetailScreen(
                slug: state.pathParameters['slug']!,
                preload: state.extra as SnPost?,
              ),
            ),
          ),
        ],
      ),
      GoRoute(
        path: '/account',
        name: 'account',
        pageBuilder: (context, state) => NoTransitionPage(
          child: const AccountScreen(),
        ),
      ),
      GoRoute(
        path: '/chat',
        name: 'chat',
        pageBuilder: (context, state) => NoTransitionPage(
          child: const ChatScreen(),
        ),
        routes: [
          GoRoute(
            path: '/chat/:scope/:alias',
            name: 'chatRoom',
            builder: (context, state) => AppBackground(
              isLessOptimization: true,
              child: ChatRoomScreen(
                scope: state.pathParameters['scope']!,
                alias: state.pathParameters['alias']!,
              ),
            ),
          ),
          GoRoute(
            path: '/chat/manage',
            name: 'chatManage',
            pageBuilder: (context, state) => CustomTransitionPage(
              child: ChatManageScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeThroughTransition(
                  animation: animation,
                  secondaryAnimation: secondaryAnimation,
                  fillColor: Colors.transparent,
                  child: AppBackground(
                    isLessOptimization: true,
                    child: child,
                  ),
                );
              },
            ),
          ),
        ],
      ),
      GoRoute(
        path: '/realm',
        name: 'realm',
        pageBuilder: (context, state) => NoTransitionPage(
          child: const RealmScreen(),
        ),
        routes: [
          GoRoute(
            path: '/realm/manage',
            name: 'realmManage',
            pageBuilder: (context, state) => CustomTransitionPage(
              child: RealmManageScreen(
                editingRealmAlias: state.uri.queryParameters['editing'],
              ),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeThroughTransition(
                  animation: animation,
                  secondaryAnimation: secondaryAnimation,
                  fillColor: Colors.transparent,
                  child: AppBackground(
                    isLessOptimization: true,
                    child: child,
                  ),
                );
              },
            ),
          ),
        ],
      ),
      GoRoute(
        path: '/album',
        name: 'album',
        pageBuilder: (context, state) => NoTransitionPage(
          child: const AlbumScreen(),
        ),
      ),
      GoRoute(
        path: '/notification',
        name: 'notification',
        pageBuilder: (context, state) => NoTransitionPage(
          child: const NotificationScreen(),
        ),
      ),
    ],
  ),
  ShellRoute(
    builder: (context, state, child) => AppPageScaffold(body: child),
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
    builder: (context, state, child) => AppPageScaffold(body: child),
    routes: [
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  ),
];

final appRouter = GoRouter(
  routes: [
    ShellRoute(
      routes: _appRoutes,
      builder: (context, state, child) => AppRootScaffold(body: child),
    ),
  ],
);
