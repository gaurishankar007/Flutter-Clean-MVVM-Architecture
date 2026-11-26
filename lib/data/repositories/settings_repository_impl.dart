import 'package:clean_architecture/core/data/states/data_state.dart';
import 'package:clean_architecture/core/types/types.dart';
import 'package:clean_architecture/data/services/local/settings_local_service.dart';
import 'package:clean_architecture/domain/models/app_settings.dart';
import 'package:clean_architecture/domain/repositories/settings_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SettingsRepository)
final class SettingsRepositoryImpl({required final SettingsLocalService _local})
    implements SettingsRepository {
  AppSettings _current = const AppSettings();

  @override
  AppSettings get current => _current;

  // A failed read is already recorded; the app starts with defaults.
  @override
  Future<void> load() async {
    if (await _local.read() case SuccessState(:final data?)) {
      _current = data;
    }
  }

  @override
  FutureVoid save(AppSettings settings) async {
    final result = await _local.write(settings);
    if (result is SuccessState) {
      _current = settings;
    }
    return result;
  }
}
