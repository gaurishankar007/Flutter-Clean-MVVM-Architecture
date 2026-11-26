import 'package:clean_architecture/core/app_initializer.dart';
import 'package:clean_architecture/ui/application.dart';
import 'package:clean_architecture/ui/startup/startup_error_app.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

/// Initialises the app for [environment], then runs it, or the startup
/// error screen with Retry.
Future<void> runCleanArchitectureApp({required String environment}) async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy(); // Web: /home/tasks instead of /#/home/tasks.
  final initialized = await AppInitializer.initializeApp(
    environment: environment,
  );
  runApp(
    initialized
        ? const ProviderScope(child: CleanArchitectureApp())
        : StartupErrorApp(
            onRetry: () => runCleanArchitectureApp(environment: environment),
          ),
  );
}
