import 'package:clean_architecture/core/domain/entities/user_data.dart';
import 'package:clean_architecture/features/auth/domain/repositories/session_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class SetSessionUseCase(final SessionRepository _sessionRepository) {
  void call(UserData userData) => _sessionRepository.setUserData = userData;
}
