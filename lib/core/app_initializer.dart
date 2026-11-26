import 'package:clean_architecture/config/injector/injector.dart';
import 'package:clean_architecture/core/clients/remote/connectivity_client.dart';
import 'package:clean_architecture/core/errors/error_handler.dart';
import 'package:clean_architecture/data/services/local/session_local_service.dart';
import 'package:clean_architecture/domain/repositories/settings_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

/// Prepares everything the first screen needs. See docs/architecture/app_startup.md.
abstract final class AppInitializer {
  static bool _dependenciesConfigured = false;

  /// Returns `false` when the app can't start (shows StartupErrorApp).
  static Future<bool> initializeApp({required String environment}) async {
    try {
      // Steps 1–2 run once, even when Retry calls this again.
      if (!_dependenciesConfigured) {
        await dotenv.load();
        await configureDependencies(environment: environment);
        ErrorHandlerProvider.I.configureErrorHandlers();
        _dependenciesConfigured = true;
      }

      // Step 3: what the router and the first screen read synchronously.
      await (
        GetIt.I<SessionLocalService>().load(),
        GetIt.I<SettingsRepository>().load(),
        GetIt.I<ConnectivityClient>().initialize(),
      ).wait;
      return true;
    } catch (error, stackTrace) {
      debugPrint('AppInitializer failed: $error\n$stackTrace');
      return false;
    }
  }
}
