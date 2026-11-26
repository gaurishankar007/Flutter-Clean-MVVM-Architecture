import 'package:clean_architecture/domain/repositories/auth_repository.dart';
import 'package:clean_architecture/domain/repositories/settings_repository.dart';
import 'package:clean_architecture/ui/core/providers/base/base_notifier.dart';
import 'package:clean_architecture/ui/features/startup/models/startup_destination.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Decides the first screen. Stateless: the splash only shows the brand.
class SplashNotifier extends BaseNotifier<void> {
  @override
  void build() {}

  /// Waits at least [minDuration], so the splash doesn't flash.
  Future<StartupDestination> resolve({
    Duration minDuration = const Duration(milliseconds: 900),
  }) async {
    await Future<void>.delayed(minDuration);
    if (!GetIt.I<SettingsRepository>().current.onboardingSeen) {
      return .onboarding;
    }
    return GetIt.I<AuthRepository>().isLoggedIn ? .home : .login;
  }
}

final splashProvider = NotifierProvider.autoDispose(SplashNotifier.new);
