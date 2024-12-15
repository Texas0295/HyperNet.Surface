import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:surface/screens/abuse_report.dart';
import 'package:surface/screens/account.dart';
import 'package:surface/screens/account/pfp.dart';
import 'package:surface/screens/account/profile_edit.dart';
import 'package:surface/screens/account/publishers/publisher_edit.dart';
import 'package:surface/screens/account/publishers/publisher_new.dart';
import 'package:surface/screens/account/publishers/publishers.dart';
import 'package:surface/screens/album.dart';
import 'package:surface/screens/auth/login.dart';
import 'package:surface/screens/auth/register.dart';
import 'package:surface/screens/chat.dart';
import 'package:surface/screens/chat/call_room.dart';
import 'package:surface/screens/chat/channel_detail.dart';
import 'package:surface/screens/chat/manage.dart';
import 'package:surface/screens/chat/room.dart';
import 'package:surface/screens/explore.dart';
import 'package:surface/screens/friend.dart';
import 'package:surface/screens/home.dart';
import 'package:surface/screens/notification.dart';
import 'package:surface/screens/post/post_detail.dart';
import 'package:surface/screens/post/post_editor.dart';
import 'package:surface/screens/post/publisher_page.dart';
import 'package:surface/screens/post/post_search.dart';
import 'package:surface/screens/realm.dart';
import 'package:surface/screens/realm/manage.dart';
import 'package:surface/screens/realm/realm_detail.dart';
import 'package:surface/screens/settings.dart';
import 'package:surface/screens/sharing.dart';
import 'package:surface/types/post.dart';
import 'package:surface/widgets/about.dart';
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
            path: '/write/:mode',
            name: 'postEditor',
            builder: (context, state) => AppBackground(
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
                extraProps: state.extra as PostEditorExtraProps?,
              ),
            ),
          ),
          GoRoute(
            path: '/search',
            name: 'postSearch',
            builder: (context, state) => const AppBackground(
              child: PostSearchScreen(),
            ),
          ),
          GoRoute(
            path: '/publishers/:name',
            name: 'postPublisher',
            builder: (context, state) => AppBackground(
              child: PostPublisherScreen(name: state.pathParameters['name']!),
            ),
          ),
          GoRoute(
            path: '/:slug',
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
        routes: [],
      ),
      GoRoute(
        path: '/chat',
        name: 'chat',
        pageBuilder: (context, state) => NoTransitionPage(
          child: const ChatScreen(),
        ),
        routes: [
          GoRoute(
            path: '/:scope/:alias',
            name: 'chatRoom',
            builder: (context, state) => AppBackground(
              child: ChatRoomScreen(
                scope: state.pathParameters['scope']!,
                alias: state.pathParameters['alias']!,
              ),
            ),
          ),
          GoRoute(
            path: '/:scope/:alias/call',
            name: 'chatCallRoom',
            builder: (context, state) => AppBackground(
              child: CallRoomScreen(
                scope: state.pathParameters['scope']!,
                alias: state.pathParameters['alias']!,
              ),
            ),
          ),
          GoRoute(
            path: '/:scope/:alias/detail',
            name: 'channelDetail',
            builder: (context, state) => AppBackground(
              child: ChannelDetailScreen(
                scope: state.pathParameters['scope']!,
                alias: state.pathParameters['alias']!,
              ),
            ),
          ),
          GoRoute(
            path: '/manage',
            name: 'chatManage',
            pageBuilder: (context, state) => CustomTransitionPage(
              child: ChatManageScreen(
                editingChannelAlias: state.uri.queryParameters['editing'],
              ),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeThroughTransition(
                  animation: animation,
                  secondaryAnimation: secondaryAnimation,
                  fillColor: Colors.transparent,
                  child: AppBackground(
                    child: child,
                  ),
                );
              },
            ),
          ),
          GoRoute(
            path: '/:alias',
            name: 'realmDetail',
            builder: (context, state) => AppBackground(
              child: RealmDetailScreen(alias: state.pathParameters['alias']!),
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
            path: '/manage',
            name: 'realmManage',
            pageBuilder: (context, state) => CustomTransitionPage(
              child: RealmManageScreen(
                editingRealmAlias: state.uri.queryParameters['editing'],
              ),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeThroughTransition(
                  animation: animation,
                  secondaryAnimation: secondaryAnimation,
                  fillColor: Colors.transparent,
                  child: AppBackground(
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
        path: '/friend',
        name: 'friend',
        pageBuilder: (context, state) => NoTransitionPage(
          child: const FriendScreen(),
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
        builder: (context, state) => const AppBackground(
          child: LoginScreen(),
        ),
      ),
      GoRoute(
        path: '/auth/register',
        name: 'authRegister',
        builder: (context, state) => const AppBackground(
          child: RegisterScreen(),
        ),
      ),
      GoRoute(
        path: '/reports',
        name: 'abuseReport',
        builder: (context, state) => const AppBackground(
          child: AbuseReportScreen(),
        ),
      ),
      GoRoute(
        path: '/account/profile/edit',
        name: 'accountProfileEdit',
        builder: (context, state) => const AppBackground(
          child: ProfileEditScreen(),
        ),
      ),
      GoRoute(
        path: '/account/publishers',
        name: 'accountPublishers',
        builder: (context, state) => const AppBackground(
          child: PublisherScreen(),
        ),
      ),
      GoRoute(
        path: '/account/publishers/new',
        name: 'accountPublisherNew',
        builder: (context, state) => const AppBackground(
          child: AccountPublisherNewScreen(),
        ),
      ),
      GoRoute(
        path: '/account/publishers/edit/:name',
        name: 'accountPublisherEdit',
        builder: (context, state) => AppBackground(
          child: AccountPublisherEditScreen(
            name: state.pathParameters['name']!,
          ),
        ),
      ),
    ],
  ),
  GoRoute(
    path: '/account/:name',
    name: 'accountProfilePage',
    pageBuilder: (context, state) => NoTransitionPage(
      child: UserScreen(name: state.pathParameters['name']!),
    ),
  ),
  ShellRoute(
    builder: (context, state, child) => AppPageScaffold(body: child),
    routes: [
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const AppBackground(
          child: SettingsScreen(),
        ),
      ),
    ],
  ),
  ShellRoute(
    builder: (context, state, child) => AppPageScaffold(body: child),
    routes: [
      GoRoute(
        path: '/about',
        name: 'about',
        builder: (context, state) => const AppBackground(
          child: AboutScreen(),
        ),
      ),
    ],
  ),
];

final appRouter = GoRouter(
  routes: [
    ShellRoute(
      routes: _appRoutes,
      builder: (context, state, child) => AppRootScaffold(
        body: AppSharingListener(child: child),
      ),
    ),
  ],
);
