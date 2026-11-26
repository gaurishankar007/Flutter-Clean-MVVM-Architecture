import 'package:auto_route/auto_route.dart';
import 'package:clean_architecture/domain/repositories/auth_repository.dart';
import 'package:clean_architecture/routing/routes.gr.dart';
import 'package:get_it/get_it.dart';

/// Keeps a signed-in user off the login screen.
final class const UnauthenticatedGuard() extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (!GetIt.I<AuthRepository>().isLoggedIn) {
      return resolver.next();
    }
    resolver.redirectUntil(const HomeShellRoute(), replace: true);
  }
}
