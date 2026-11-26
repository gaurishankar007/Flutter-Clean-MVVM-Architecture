import 'package:auto_route/auto_route.dart';
import 'package:clean_architecture/routing/guards/authenticated_guard.dart';
import 'package:clean_architecture/routing/guards/unauthenticated_guard.dart';
import 'package:clean_architecture/routing/routes.gr.dart';

/// Route tree. See docs/core/routing.md.
@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  static const _auth = [AuthenticatedGuard()];

  @override
  RouteType get defaultRouteType => const .adaptive();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, path: '/', initial: true),
    AutoRoute(page: OnboardingRoute.page, path: '/onboarding'),
    AutoRoute(
      page: LoginRoute.page,
      path: '/login',
      guards: const [UnauthenticatedGuard()],
    ),
    AutoRoute(
      page: HomeShellRoute.page,
      path: '/home',
      guards: _auth,
      children: [
        AutoRoute(page: TodosRoute.page, path: 'tasks', initial: true),
        AutoRoute(page: NotificationsRoute.page, path: 'inbox'),
        AutoRoute(page: ProfileRoute.page, path: 'profile'),
        AutoRoute(page: SettingsRoute.page, path: 'settings'),
      ],
    ),
    // Full-screen pages above the tabs. The editor ('/tasks/editor?id=...',
    // no id for a new task) comes before '/tasks/:todoId'.
    AutoRoute(page: TodoEditorRoute.page, path: '/tasks/editor', guards: _auth),
    AutoRoute(
      page: TodoDetailRoute.page,
      path: '/tasks/:todoId',
      guards: _auth,
    ),
    AutoRoute(
      page: EditProfileRoute.page,
      path: '/profile/edit',
      guards: _auth,
    ),
    AutoRoute(page: ErrorLogRoute.page, path: '/settings/error-log'),
    RedirectRoute(path: '*', redirectTo: '/'),
  ];
}
