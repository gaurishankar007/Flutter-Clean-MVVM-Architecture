import 'package:clean_architecture/core/data/states/data_state.dart';
import 'package:clean_architecture/core/errors/error_handler.dart';
import 'package:clean_architecture/core/types/types.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';

@lazySingleton
class AppInfoService {
  FutureData<String> version() => ErrorHandlerProvider.I.execute(() async {
    final info = await PackageInfo.fromPlatform();
    return SuccessState(data: '${info.version} (${info.buildNumber})');
  }, action: 'platform.appVersion');
}
