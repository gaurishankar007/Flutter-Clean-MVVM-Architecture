import 'package:clean_architecture/core/types/types.dart';

abstract interface class AppInfoRepository {
  /// `1.0.0 (1)`.
  FutureData<String> version();
}
