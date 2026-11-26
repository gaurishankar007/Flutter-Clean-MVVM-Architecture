import 'package:clean_architecture/core/types/types.dart';
import 'package:clean_architecture/data/services/platform/app_info_service.dart';
import 'package:clean_architecture/domain/repositories/app_info_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AppInfoRepository)
final class AppInfoRepositoryImpl({required final AppInfoService _service})
    implements AppInfoRepository {
  @override
  FutureData<String> version() => _service.version();
}
