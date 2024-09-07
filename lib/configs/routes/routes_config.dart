import 'package:chat/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

GoRouter routerConfig() =>
    GoRouter(initialLocation: UsersViewHome.link, routes: _routes);

final List<RouteBase> _routes = [
  _authRoutes,
  ..._homeRoutes,
];

final RouteBase _authRoutes = StatefulShellRoute.indexedStack(
  pageBuilder: (context, state, navigationShell) {
    return MaterialPage(
        child: AuthenticationLayout(navigationShell: navigationShell));
  },
  branches: [
    StatefulShellBranch(routes: [
      GoRoute(
        path: LoginViewAuthentication.link,
        builder: (context, state) => const LoginViewAuthentication(),
      ),
    ]),
    StatefulShellBranch(routes: [
      GoRoute(
        path: RegisterViewAuthentication.link,
        builder: (context, state) => const RegisterViewAuthentication(),
      ),
    ]),
  ],
);
final List<RouteBase> _homeRoutes = [
  StatefulShellRoute.indexedStack(
    pageBuilder: (context, state, navigationShell) {
      return MaterialPage(child: HomeLayout(navigationShell: navigationShell));
    },
    branches: [
      StatefulShellBranch(routes: [
        GoRoute(
          path: UsersViewHome.link,
          builder: (context, state) => const UsersViewHome(),
        ),
      ]),
    ],
  ),
  GoRoute(
    path: ChatPageHome.link,
    builder: (context, state) => const ChatPageHome(),
  ),
];
