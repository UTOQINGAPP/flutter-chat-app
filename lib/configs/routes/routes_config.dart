import 'package:chat/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

GoRouter routerConfig() =>
    GoRouter(initialLocation: LoginViewAuthentication.link, routes: _routes);

final List<RouteBase> _routes = [
  _authRoutes,
  //_homeRoutes,
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
