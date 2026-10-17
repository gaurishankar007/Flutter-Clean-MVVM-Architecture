import 'package:clean_architecture/core/domain/entities/user_data.dart';
import 'package:clean_architecture/core/domain/use_cases/use_case.dart';
import 'package:clean_architecture/core/types/types.dart';
import 'package:clean_architecture/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class SaveUserDataUseCase({required final AuthRepository _authRepository})
    implements UseCase<void, UserData> {
  @override
  FutureVoid call(UserData request) => _authRepository.saveUserData(request);
}
