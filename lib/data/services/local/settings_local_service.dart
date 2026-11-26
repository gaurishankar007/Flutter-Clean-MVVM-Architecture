import 'package:clean_architecture/core/constants/storage_keys.dart';
import 'package:clean_architecture/core/data/states/data_state.dart';
import 'package:clean_architecture/core/errors/error_handler.dart';
import 'package:clean_architecture/core/types/types.dart';
import 'package:clean_architecture/data/models/local/settings_local.dart';
import 'package:clean_architecture/data/services/local/key_value_local_service.dart';
import 'package:clean_architecture/domain/models/app_settings.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SettingsLocalService({required final KeyValueLocalService _keyValue}) {
  FutureData<AppSettings> read() => ErrorHandlerProvider.I.execute(() async {
    final json = await _keyValue.read(StorageKeys.settings);
    return SuccessState(
      data: json == null
          ? const AppSettings()
          : SettingsLocal.fromLocalJson(json),
      origin: .local,
    );
  }, action: 'settings.local.read');

  FutureVoid write(AppSettings settings) =>
      ErrorHandlerProvider.I.execute(() async {
        await _keyValue.write(StorageKeys.settings, settings.toLocalJson());
        return const SuccessState.nil(origin: .local);
      }, action: 'settings.local.write');
}
