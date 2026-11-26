import 'package:clean_architecture/domain/models/app_theme_mode.dart';
import 'package:equatable/equatable.dart';

/// User preferences and one-time flags.
final class const AppSettings({
  final AppThemeMode themeMode = .system,
  final bool dueReminders = true,
  final bool onboardingSeen = false,
}) extends Equatable {
  AppSettings copyWith({
    AppThemeMode? themeMode,
    bool? dueReminders,
    bool? onboardingSeen,
  }) => AppSettings(
    themeMode: themeMode ?? this.themeMode,
    dueReminders: dueReminders ?? this.dueReminders,
    onboardingSeen: onboardingSeen ?? this.onboardingSeen,
  );

  @override
  List<Object?> get props => [themeMode, dueReminders, onboardingSeen];
}
