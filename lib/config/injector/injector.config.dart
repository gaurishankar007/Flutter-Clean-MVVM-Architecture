// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:clean_architecture/config/app_config.dart' as _i37;
import 'package:clean_architecture/core/clients/database/app_database.dart'
    as _i119;
import 'package:clean_architecture/core/clients/remote/connectivity_client.dart'
    as _i398;
import 'package:clean_architecture/core/clients/remote/http/http_auth_interceptor.dart'
    as _i567;
import 'package:clean_architecture/core/clients/remote/http/http_client.dart'
    as _i244;
import 'package:clean_architecture/core/clients/remote/http/token_store.dart'
    as _i885;
import 'package:clean_architecture/data/repositories/app_info_repository_impl.dart'
    as _i562;
import 'package:clean_architecture/data/repositories/auth_repository_impl.dart'
    as _i268;
import 'package:clean_architecture/data/repositories/error_log_repository_impl.dart'
    as _i738;
import 'package:clean_architecture/data/repositories/notification_repository_impl.dart'
    as _i218;
import 'package:clean_architecture/data/repositories/settings_repository_impl.dart'
    as _i1071;
import 'package:clean_architecture/data/repositories/todo_repository_impl.dart'
    as _i761;
import 'package:clean_architecture/data/repositories/user_repository_impl.dart'
    as _i971;
import 'package:clean_architecture/data/services/local/error_log_local_service.dart'
    as _i699;
import 'package:clean_architecture/data/services/local/key_value_local_service.dart'
    as _i787;
import 'package:clean_architecture/data/services/local/notification_local_service.dart'
    as _i387;
import 'package:clean_architecture/data/services/local/session_local_service.dart'
    as _i559;
import 'package:clean_architecture/data/services/local/settings_local_service.dart'
    as _i744;
import 'package:clean_architecture/data/services/local/todo_local_service.dart'
    as _i345;
import 'package:clean_architecture/data/services/platform/app_info_service.dart'
    as _i198;
import 'package:clean_architecture/data/services/platform/image_picker_service.dart'
    as _i671;
import 'package:clean_architecture/data/services/remote/auth_api_service.dart'
    as _i952;
import 'package:clean_architecture/data/services/remote/todo_api_service.dart'
    as _i411;
import 'package:clean_architecture/data/services/remote/user_api_service.dart'
    as _i281;
import 'package:clean_architecture/domain/repositories/app_info_repository.dart'
    as _i449;
import 'package:clean_architecture/domain/repositories/auth_repository.dart'
    as _i314;
import 'package:clean_architecture/domain/repositories/error_log_repository.dart'
    as _i299;
import 'package:clean_architecture/domain/repositories/notification_repository.dart'
    as _i612;
import 'package:clean_architecture/domain/repositories/settings_repository.dart'
    as _i76;
import 'package:clean_architecture/domain/repositories/todo_repository.dart'
    as _i42;
import 'package:clean_architecture/domain/repositories/user_repository.dart'
    as _i1038;
import 'package:clean_architecture/domain/use_cases/login_use_case.dart'
    as _i334;
import 'package:clean_architecture/domain/use_cases/logout_use_case.dart'
    as _i768;
import 'package:clean_architecture/domain/use_cases/save_todo_use_case.dart'
    as _i1013;
import 'package:clean_architecture/domain/use_cases/set_todo_completed_use_case.dart'
    as _i821;
import 'package:clean_architecture/domain/use_cases/sync_todos_use_case.dart'
    as _i642;
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:get_it/get_it.dart' as _i174;
import 'package:image_picker/image_picker.dart' as _i183;
import 'package:injectable/injectable.dart' as _i526;

const String _staging = 'staging';
const String _development = 'development';
const String _production = 'production';

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt initialize({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final connectivityModule = _$ConnectivityModule();
    final imagePickerModule = _$ImagePickerModule();
    final tokenStoreModule = _$TokenStoreModule();
    gh.lazySingleton<_i895.Connectivity>(() => connectivityModule.connectivity);
    gh.lazySingleton<_i198.AppInfoService>(() => _i198.AppInfoService());
    gh.lazySingleton<_i183.ImagePicker>(() => imagePickerModule.imagePicker);
    gh.lazySingleton<_i398.ConnectivityClient>(
      () =>
          _i398.ConnectivityClientImpl(connectivity: gh<_i895.Connectivity>()),
    );
    gh.lazySingleton<_i449.AppInfoRepository>(
      () => _i562.AppInfoRepositoryImpl(service: gh<_i198.AppInfoService>()),
    );
    gh.lazySingleton<_i671.ImagePickerService>(
      () => _i671.ImagePickerService(picker: gh<_i183.ImagePicker>()),
    );
    gh.lazySingleton<_i37.AppConfig>(
      () => _i37.AppConfigStg(),
      registerFor: {_staging},
    );
    gh.lazySingleton<_i699.ErrorLogLocalService>(
      () => _i699.ErrorLogLocalService(database: gh<_i119.AppDatabase>()),
    );
    gh.lazySingleton<_i787.KeyValueLocalService>(
      () => _i787.KeyValueLocalService(database: gh<_i119.AppDatabase>()),
    );
    gh.lazySingleton<_i387.NotificationLocalService>(
      () => _i387.NotificationLocalService(database: gh<_i119.AppDatabase>()),
    );
    gh.lazySingleton<_i345.TodoLocalService>(
      () => _i345.TodoLocalService(database: gh<_i119.AppDatabase>()),
    );
    gh.lazySingleton<_i37.AppConfig>(
      () => _i37.AppConfigDev(),
      registerFor: {_development},
    );
    gh.lazySingleton<_i299.ErrorLogRepository>(
      () =>
          _i738.ErrorLogRepositoryImpl(local: gh<_i699.ErrorLogLocalService>()),
    );
    gh.lazySingleton<_i37.AppConfig>(
      () => _i37.AppConfigProd(),
      registerFor: {_production},
    );
    gh.lazySingleton<_i612.NotificationRepository>(
      () => _i218.NotificationRepositoryImpl(
        local: gh<_i387.NotificationLocalService>(),
      ),
    );
    gh.lazySingleton<_i559.SessionLocalService>(
      () =>
          _i559.SessionLocalService(keyValue: gh<_i787.KeyValueLocalService>()),
    );
    gh.lazySingleton<_i744.SettingsLocalService>(
      () => _i744.SettingsLocalService(
        keyValue: gh<_i787.KeyValueLocalService>(),
      ),
    );
    gh.lazySingleton<_i76.SettingsRepository>(
      () => _i1071.SettingsRepositoryImpl(
        local: gh<_i744.SettingsLocalService>(),
      ),
    );
    gh.lazySingleton<_i885.TokenStore>(
      () => tokenStoreModule.tokenStore(gh<_i559.SessionLocalService>()),
    );
    gh.lazySingleton<_i567.HttpAuthInterceptor>(
      () => _i567.HttpAuthInterceptor(
        tokenStore: gh<_i885.TokenStore>(),
        appConfig: gh<_i37.AppConfig>(),
      ),
    );
    gh.lazySingleton<_i244.HttpClient>(
      () => _i244.HttpClientImpl(
        appConfig: gh<_i37.AppConfig>(),
        authInterceptor: gh<_i567.HttpAuthInterceptor>(),
      ),
    );
    gh.lazySingleton<_i952.AuthApiService>(
      () => _i952.AuthApiService(http: gh<_i244.HttpClient>()),
    );
    gh.lazySingleton<_i411.TodoApiService>(
      () => _i411.TodoApiService(http: gh<_i244.HttpClient>()),
    );
    gh.lazySingleton<_i281.UserApiService>(
      () => _i281.UserApiService(http: gh<_i244.HttpClient>()),
    );
    gh.lazySingleton<_i1038.UserRepository>(
      () => _i971.UserRepositoryImpl(
        api: gh<_i281.UserApiService>(),
        session: gh<_i559.SessionLocalService>(),
        imagePicker: gh<_i671.ImagePickerService>(),
        connectivity: gh<_i398.ConnectivityClient>(),
      ),
    );
    gh.lazySingleton<_i42.TodoRepository>(
      () => _i761.TodoRepositoryImpl(
        local: gh<_i345.TodoLocalService>(),
        api: gh<_i411.TodoApiService>(),
        connectivity: gh<_i398.ConnectivityClient>(),
      ),
    );
    gh.lazySingleton<_i314.AuthRepository>(
      () => _i268.AuthRepositoryImpl(
        api: gh<_i952.AuthApiService>(),
        session: gh<_i559.SessionLocalService>(),
      ),
    );
    gh.factory<_i642.SyncTodosUseCase>(
      () => _i642.SyncTodosUseCase(
        todos: gh<_i42.TodoRepository>(),
        users: gh<_i1038.UserRepository>(),
        notifications: gh<_i612.NotificationRepository>(),
        settings: gh<_i76.SettingsRepository>(),
      ),
    );
    gh.factory<_i334.LoginUseCase>(
      () => _i334.LoginUseCase(
        auth: gh<_i314.AuthRepository>(),
        notifications: gh<_i612.NotificationRepository>(),
        syncTodos: gh<_i642.SyncTodosUseCase>(),
      ),
    );
    gh.factory<_i768.LogoutUseCase>(
      () => _i768.LogoutUseCase(
        auth: gh<_i314.AuthRepository>(),
        todos: gh<_i42.TodoRepository>(),
        notifications: gh<_i612.NotificationRepository>(),
      ),
    );
    gh.factory<_i1013.SaveTodoUseCase>(
      () => _i1013.SaveTodoUseCase(
        todos: gh<_i42.TodoRepository>(),
        notifications: gh<_i612.NotificationRepository>(),
      ),
    );
    gh.factory<_i821.SetTodoCompletedUseCase>(
      () => _i821.SetTodoCompletedUseCase(
        todos: gh<_i42.TodoRepository>(),
        notifications: gh<_i612.NotificationRepository>(),
      ),
    );
    return this;
  }
}

class _$ConnectivityModule extends _i398.ConnectivityModule {}

class _$ImagePickerModule extends _i671.ImagePickerModule {}

class _$TokenStoreModule extends _i559.TokenStoreModule {}
