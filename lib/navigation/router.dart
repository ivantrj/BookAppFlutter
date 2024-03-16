import 'package:flutter_tabs_starter/navigation/route.dart';
import 'package:flutter_tabs_starter/screens/home_page.dart';
import 'package:flutter_tabs_starter/screens/inbox_page.dart';
import 'package:flutter_tabs_starter/screens/library_page.dart';
import 'package:flutter_tabs_starter/screens/settings_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: AppRoute.home.path,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: AppRoute.inbox.path,
      builder: (context, state) => const InboxPage(),
    ),
    GoRoute(
      path: AppRoute.library.path,
      builder: (context, state) => const LibraryPage(),
    ),
    GoRoute(
      path: AppRoute.settings.path,
      builder: (context, state) => const SettingsPage(),
    ),
  ],
);
