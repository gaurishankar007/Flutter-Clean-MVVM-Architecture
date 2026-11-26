import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

abstract final class Flavor {
  static const production = 'production';
  static const staging = 'staging';
  static const development = 'development';
}

/// Per-flavor configuration. Base URLs come from `.env` (see `.env.example`);
/// the fallback is the public demo backend the example features use.
sealed class const AppConfig({
  required final String appTitle,
  required final String apiBaseUrl,
  required final String flavor,
}) {
  static const demoBaseUrl = 'https://dummyjson.com/';
}

@LazySingleton(as: AppConfig, env: [Flavor.production])
final class AppConfigProd() extends AppConfig {
  this
    : super(
        appTitle: 'Clean Architecture',
        apiBaseUrl: dotenv.maybeGet('BASE_PRODUCTION') ?? AppConfig.demoBaseUrl,
        flavor: Flavor.production,
      );
}

@LazySingleton(as: AppConfig, env: [Flavor.staging])
final class AppConfigStg() extends AppConfig {
  this
    : super(
        appTitle: 'Clean Architecture STG',
        apiBaseUrl: dotenv.maybeGet('BASE_STAGING') ?? AppConfig.demoBaseUrl,
        flavor: Flavor.staging,
      );
}

@LazySingleton(as: AppConfig, env: [Flavor.development])
final class AppConfigDev() extends AppConfig {
  this
    : super(
        appTitle: 'Clean Architecture DEV',
        apiBaseUrl:
            dotenv.maybeGet('BASE_DEVELOPMENT') ?? AppConfig.demoBaseUrl,
        flavor: Flavor.development,
      );
}

/// Access to the registered [AppConfig].
abstract final class AppConfigUtil {
  static AppConfig get I => GetIt.I<AppConfig>();
}
