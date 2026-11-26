import 'package:auto_route/auto_route.dart';
import 'package:clean_architecture/domain/repositories/auth_repository.dart';
import 'package:clean_architecture/routing/routes.gr.dart';
import 'package:get_it/get_it.dart';

/// Lets a signed-in user through; otherwise opens login.
final class const AuthenticatedGuard() extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (GetIt.I<AuthRepository>().isLoggedIn) {
      return resolver.next();
    }
    resolver.redirectUntil(const LoginRoute(), replace: true);
  }
}
