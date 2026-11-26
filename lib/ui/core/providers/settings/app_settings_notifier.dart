import 'package:clean_architecture/core/data/states/data_state.dart';
import 'package:clean_architecture/domain/models/app_settings.dart';
import 'package:clean_architecture/domain/models/app_theme_mode.dart';
import 'package:clean_architecture/domain/repositories/settings_repository.dart';
import 'package:clean_architecture/ui/core/providers/base/base_notifier.dart';
import 'package:clean_architecture/ui/core/providers/settings/app_settings_state.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// App-wide preferences (theme, reminders, onboarding flag), keep-alive.
class AppSettingsNotifier extends BaseNotifier<AppSettingsState> {
  late final SettingsRepository _repository;

  @override
  AppSettingsState build() {
    _repository = GetIt.I<SettingsRepository>();
    return AppSettingsState(settings: _repository.current);
  }

  Future<void> setThemeMode(AppThemeMode mode) =>
      _save('settings.themeMode', state.settings.copyWith(themeMode: mode));

  Future<void> setDueReminders(bool enabled) => _save(
    'settings.dueReminders',
    state.settings.copyWith(dueReminders: enabled),
  );

  Future<void> completeOnboarding() => _save(
    'onboarding.complete',
    state.settings.copyWith(onboardingSeen: true),
  );

  // Optimistic: the UI changes at once and rolls back if saving fails.
  Future<void> _save(String action, AppSettings next) =>
      runFlow(action, () async {
        final previous = state.settings;
        state = AppSettingsState(settings: next);
        final result = await _repository.save(next);
        if (!ref.mounted) {
          return;
        }
        if (result is FailureState) {
          state = AppSettingsState(
            settings: previous,
            message: trackFailure(result),
          );
        }
      });
}

final appSettingsProvider = NotifierProvider(AppSettingsNotifier.new);
