import 'package:clean_architecture/core/domain/use_cases/use_case.dart';
import 'package:clean_architecture/core/types/types.dart';
import 'package:clean_architecture/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class CheckAuthenticationUseCase({
  required final AuthRepository _authRepository,
}) implements UseCaseNoParameter<bool> {
  @override
  FutureBool call() => _authRepository.checkAuth();
}
