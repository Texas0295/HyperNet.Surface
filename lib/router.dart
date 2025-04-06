import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:surface/screens/abuse_report.dart';
import 'package:surface/screens/account.dart';
import 'package:surface/screens/account/punishments.dart';
import 'package:surface/screens/account/settings.dart';
import 'package:surface/screens/account/action_events.dart';
import 'package:surface/screens/account/badges.dart';
import 'package:surface/screens/account/contact_methods.dart';
import 'package:surface/screens/account/factor_settings.dart';
import 'package:surface/screens/account/keypairs.dart';
import 'package:surface/screens/account/prefs/notify.dart';
import 'package:surface/screens/account/prefs/security.dart';
import 'package:surface/screens/account/profile_page.dart';
import 'package:surface/screens/account/profile_edit.dart';
import 'package:surface/screens/account/programs.dart';
import 'package:surface/screens/account/publishers/publisher_edit.dart';
import 'package:surface/screens/account/publishers/publisher_new.dart';
import 'package:surface/screens/account/publishers/publishers.dart';
import 'package:surface/screens/account/auth_tickets.dart';
import 'package:surface/screens/album.dart';
import 'package:surface/screens/auth/login.dart';
import 'package:surface/screens/auth/register.dart';
import 'package:surface/screens/chat.dart';
import 'package:surface/screens/chat/channel_detail.dart';
import 'package:surface/screens/chat/manage.dart';
import 'package:surface/screens/chat/room.dart';
import 'package:surface/screens/explore.dart';
import 'package:surface/screens/friend.dart';
import 'package:surface/screens/home.dart';
import 'package:surface/screens/logging.dart';
import 'package:surface/screens/feed/feed_detail.dart';
import 'package:surface/screens/notification.dart';
import 'package:surface/screens/post/post_detail.dart';
import 'package:surface/screens/post/post_draft.dart';
import 'package:surface/screens/post/post_editor.dart';
import 'package:surface/screens/post/post_shuffle.dart';
import 'package:surface/screens/post/publisher_page.dart';
import 'package:surface/screens/post/post_search.dart';
import 'package:surface/screens/realm.dart';
import 'package:surface/screens/realm/community.dart';
import 'package:surface/screens/realm/manage.dart';
import 'package:surface/screens/realm/realm_detail.dart';
import 'package:surface/screens/realm/realm_discovery.dart';
import 'package:surface/screens/settings.dart';
import 'package:surface/screens/sharing.dart';
import 'package:surface/screens/stickers.dart';
import 'package:surface/screens/stickers/pack_detail.dart';
import 'package:surface/screens/wallet.dart';
import 'package:surface/types/post.dart';
import 'package:surface/widgets/about.dart';
import 'package:surface/widgets/navigation/app_scaffold.dart';

final _appRoutes = [
  GoRoute(
    path: '/',
    name: 'home',
    builder: (context, state) => const HomeScreen(),
  ),
  GoRoute(
    path: '/posts',
    name: 'posts',
    builder: (_, __) => const SizedBox.shrink(),
    routes: [
      GoRoute(
        path: '/draft',
        name: 'postDraftBox',
        builder: (context, state) => const PostDraftBox(),
      ),
      GoRoute(
        path: '/write',
        name: 'postEditor',
        builder: (context, state) => PostEditorScreen(
          mode: state.uri.queryParameters['mode'],
          postEditId: int.tryParse(
            state.uri.queryParameters['editing'] ?? '',
          ),
          postReplyId: int.tryParse(
            state.uri.queryParameters['replying'] ?? '',
          ),
          postRepostId: int.tryParse(
            state.uri.queryParameters['reposting'] ?? '',
          ),
          extraProps: state.extra as PostEditorExtra?,
        ),
      ),
      GoRoute(
        path: '/shuffle',
        name: 'postShuffle',
        builder: (context, state) => const PostShuffleScreen(),
      ),
      GoRoute(
        path: '/search',
        name: 'postSearch',
        builder: (context, state) => PostSearchScreen(
          initialTags: state.uri.queryParameters['tags']?.split(','),
          initialCategories:
              state.uri.queryParameters['categories']?.split(','),
        ),
      ),
    ],
  ),
  ShellRoute(
    builder: (context, state, child) => ResponsiveScaffold(
      asideFlex: 2,
      contentFlex: 3,
      aside: const ExploreScreen(),
      child: child,
    ),
    routes: [
      GoRoute(
        path: '/explore',
        name: 'explore',
        builder: (context, state) => const ResponsiveScaffoldLanding(
          child: ExploreScreen(),
        ),
      ),
      GoRoute(
        path: '/posts/:slug',
        name: 'postDetail',
        builder: (context, state) => PostDetailScreen(
          key: ValueKey(state.pathParameters['slug']!),
          slug: state.pathParameters['slug']!,
          preload: state.extra as SnPost?,
        ),
      ),
      GoRoute(
        path: '/pages/:id',
        name: 'readerFeedDetail',
        builder: (context, state) => ReaderPageScreen(
          id: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: '/publishers/:name',
        name: 'postPublisher',
        builder: (context, state) =>
            PostPublisherScreen(name: state.pathParameters['name']!),
      ),
    ],
  ),
  ShellRoute(
    builder: (context, state, child) => ResponsiveScaffold(
      aside: const AccountScreen(),
      child: child,
    ),
    routes: [
      GoRoute(
        path: '/account',
        name: 'account',
        builder: (context, state) =>
            const ResponsiveScaffoldLanding(child: AccountScreen()),
        routes: [
          GoRoute(
            path: '/punishments',
            name: 'accountPunishments',
            builder: (context, state) => const PunishmentsScreen(),
          ),
          GoRoute(
            path: '/programs',
            name: 'accountProgram',
            builder: (context, state) => const AccountProgramScreen(),
          ),
          GoRoute(
            path: '/contacts',
            name: 'accountContactMethods',
            builder: (context, state) => const AccountContactMethod(),
          ),
          GoRoute(
            path: '/events',
            name: 'accountActionEvents',
            builder: (context, state) => const ActionEventScreen(),
          ),
          GoRoute(
            path: '/tickets',
            name: 'accountAuthTickets',
            builder: (context, state) => const AccountAuthTicket(),
          ),
          GoRoute(
            path: '/badges',
            name: 'accountBadges',
            builder: (context, state) => const AccountBadgesScreen(),
          ),
          GoRoute(
            path: '/wallet',
            name: 'accountWallet',
            builder: (context, state) => const WalletScreen(),
          ),
          GoRoute(
            path: '/keypairs',
            name: 'accountKeyPairs',
            builder: (context, state) => const KeyPairScreen(),
          ),
          GoRoute(
            path: '/settings',
            name: 'accountSettings',
            builder: (context, state) => AccountSettingsScreen(),
            routes: [
              GoRoute(
                path: '/notify',
                name: 'accountSettingsNotify',
                builder: (context, state) => const AccountNotifyPrefsScreen(),
              ),
              GoRoute(
                path: '/auth',
                name: 'accountSettingsSecurity',
                builder: (context, state) => const AccountSecurityPrefsScreen(),
              ),
            ],
          ),
          GoRoute(
            path: '/settings/factors',
            name: 'factorSettings',
            builder: (context, state) => FactorSettingsScreen(),
          ),
          GoRoute(
            path: '/profile/edit',
            name: 'accountProfileEdit',
            builder: (context, state) => ProfileEditScreen(),
          ),
          GoRoute(
            path: '/publishers',
            name: 'accountPublishers',
            builder: (context, state) => PublisherScreen(),
          ),
          GoRoute(
            path: '/publishers/new',
            name: 'accountPublisherNew',
            builder: (context, state) => AccountPublisherNewScreen(),
          ),
          GoRoute(
            path: '/publishers/edit/:name',
            name: 'accountPublisherEdit',
            builder: (context, state) => AccountPublisherEditScreen(
              name: state.pathParameters['name']!,
            ),
          ),
        ],
      ),
    ],
  ),
  GoRoute(
    path: '/accounts/:name',
    name: 'accountProfilePage',
    pageBuilder: (context, state) => NoTransitionPage(
      child: UserScreen(name: state.pathParameters['name']!),
    ),
  ),
  ShellRoute(
    builder: (context, state, child) =>
        ResponsiveScaffold(aside: const ChatScreen(), child: child),
    routes: [
      GoRoute(
        path: '/chat',
        name: 'chat',
        builder: (context, state) => const ResponsiveScaffoldLanding(
          child: ChatScreen(),
        ),
        routes: [
          GoRoute(
            path: '/:scope/:alias',
            name: 'chatRoom',
            builder: (context, state) => ChatRoomScreen(
              key: ValueKey(
                '${state.pathParameters['scope']!}:${state.pathParameters['alias']!}',
              ),
              scope: state.pathParameters['scope']!,
              alias: state.pathParameters['alias']!,
              extra: state.extra as ChatRoomScreenExtra?,
            ),
          ),
          GoRoute(
            path: '/:scope/:alias/detail',
            name: 'channelDetail',
            builder: (context, state) => ChannelDetailScreen(
              scope: state.pathParameters['scope']!,
              alias: state.pathParameters['alias']!,
            ),
          ),
          GoRoute(
            path: '/manage',
            name: 'chatManage',
            builder: (context, state) => ChatManageScreen(
              editingChannelAlias: state.uri.queryParameters['editing'],
            ),
          ),
        ],
      ),
    ],
  ),
  GoRoute(
    path: '/realm',
    name: 'realm',
    builder: (context, state) => const RealmScreen(),
    routes: [
      GoRoute(
        path: '/:alias/community',
        name: 'realmCommunity',
        builder: (context, state) => RealmCommunityScreen(
          alias: state.pathParameters['alias']!,
        ),
      ),
      GoRoute(
        path: '/manage',
        name: 'realmManage',
        builder: (context, state) => RealmManageScreen(
          editingRealmAlias: state.uri.queryParameters['editing'],
        ),
      ),
      GoRoute(
        path: '/discovery',
        name: 'realmDiscovery',
        builder: (context, state) => const RealmDiscoveryScreen(),
      ),
      GoRoute(
        path: '/:alias',
        name: 'realmDetail',
        builder: (context, state) =>
            RealmDetailScreen(alias: state.pathParameters['alias']!),
      ),
    ],
  ),
  GoRoute(
    path: '/stickers',
    name: 'stickers',
    builder: (context, state) => const StickerScreen(),
    routes: [
      GoRoute(
        path: '/packs/:id',
        name: 'stickerPack',
        builder: (context, state) => StickerPackScreen(
          id: int.tryParse(state.pathParameters['id']!)!,
        ),
      ),
    ],
  ),
  GoRoute(
    path: '/debug/logging',
    name: 'debugLogging',
    builder: (context, state) => const DebugLoggingScreen(),
  ),
  GoRoute(
    path: '/album',
    name: 'album',
    builder: (context, state) => const AlbumScreen(),
  ),
  GoRoute(
    path: '/friend',
    name: 'friend',
    builder: (context, state) => const FriendScreen(),
  ),
  GoRoute(
    path: '/notification',
    name: 'notification',
    builder: (context, state) => const NotificationScreen(),
  ),
  GoRoute(
    path: '/auth/login',
    name: 'authLogin',
    builder: (context, state) => LoginScreen(),
  ),
  GoRoute(
    path: '/auth/register',
    name: 'authRegister',
    builder: (context, state) => RegisterScreen(),
  ),
  GoRoute(
    path: '/reports',
    name: 'abuseReport',
    builder: (context, state) => AbuseReportScreen(),
  ),
  GoRoute(
    path: '/settings',
    name: 'settings',
    builder: (context, state) => SettingsScreen(),
  ),
  GoRoute(
    path: '/about',
    name: 'about',
    builder: (context, state) => AboutScreen(),
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
  onException: (context, state, router) {
    if (state.error is GoException) {
      router.goNamed('/');
    }
  },
  navigatorKey: GlobalKey(),
);
