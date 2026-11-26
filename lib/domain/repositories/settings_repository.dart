import 'package:clean_architecture/core/types/types.dart';
import 'package:clean_architecture/domain/models/app_settings.dart';

abstract interface class SettingsRepository {
  /// The settings loaded at startup; defaults until [load] finishes.
  AppSettings get current;

  /// Reads the stored settings. Called once at startup.
  Future<void> load();

  FutureVoid save(AppSettings settings);
}
