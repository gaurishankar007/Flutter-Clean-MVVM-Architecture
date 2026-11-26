import 'package:clean_architecture/core/types/types.dart';
import 'package:clean_architecture/domain/models/app_settings.dart';
import 'package:clean_architecture/domain/models/app_theme_mode.dart';

extension SettingsLocal on AppSettings {
  JsonMap toLocalJson() => {
    'themeMode': themeMode.name,
    'dueReminders': dueReminders,
    'onboardingSeen': onboardingSeen,
  };

  // Unknown or missing keys fall back to defaults, so old data still loads.
  static AppSettings fromLocalJson(JsonMap json) {
    const defaults = AppSettings();
    return AppSettings(
      themeMode:
          AppThemeMode.values.asNameMap()[json['themeMode']] ??
          defaults.themeMode,
      dueReminders: json['dueReminders'] as bool? ?? defaults.dueReminders,
      onboardingSeen:
          json['onboardingSeen'] as bool? ?? defaults.onboardingSeen,
    );
  }
}
