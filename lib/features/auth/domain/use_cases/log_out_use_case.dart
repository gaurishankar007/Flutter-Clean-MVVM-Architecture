import 'package:clean_architecture/features/auth/domain/repositories/session_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class LogOutUseCase(final SessionRepository _sessionRepository) {
  void call() => _sessionRepository.clearSessionData();
}
