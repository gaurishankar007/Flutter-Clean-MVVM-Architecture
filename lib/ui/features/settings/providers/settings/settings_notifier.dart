import 'package:clean_architecture/core/data/states/data_state.dart';
import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/domain/repositories/app_info_repository.dart';
import 'package:clean_architecture/domain/repositories/todo_repository.dart';
import 'package:clean_architecture/ui/core/providers/base/base_notifier.dart';
import 'package:clean_architecture/ui/features/settings/providers/settings/settings_state.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// The Settings screen's own actions. Preferences live in `appSettingsProvider`.
class SettingsNotifier extends BaseNotifier<SettingsState> {
  @override
  SettingsState build() {
    Future.microtask(_loadVersion);
    return const SettingsState();
  }

  Future<void> _loadVersion() => runFlow('settings.version', () async {
    final result = await GetIt.I<AppInfoRepository>().version();
    if (!ref.mounted) {
      return;
    }
    if (result case SuccessState(:final data?)) {
      state = state.copyWith(version: data);
    }
  });

  Future<void> clearCompleted() => runFlow('settings.clearCompleted', () async {
    final result = await GetIt.I<TodoRepository>().clearCompleted();
    if (!ref.mounted) {
      return;
    }
    state = state.copyWith(
      message: switch (result) {
        SuccessState(:final data?) => SuccessMessage(
          SettingsMessages.clearedCompleted(data),
        ),
        _ => trackFailure(result),
      },
    );
  });
}

final settingsProvider = NotifierProvider.autoDispose(SettingsNotifier.new);
