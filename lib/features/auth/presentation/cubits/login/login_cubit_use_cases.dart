import 'package:clean_architecture/features/auth/domain/use_cases/log_out_use_case.dart';
import 'package:clean_architecture/features/auth/domain/use_cases/login_use_case.dart';
import 'package:clean_architecture/features/auth/domain/use_cases/save_user_data_use_case.dart';
import 'package:clean_architecture/features/auth/domain/use_cases/set_session_use_case.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class const LoginCubitUseCases({
  required final LoginUseCase login,
  required final SaveUserDataUseCase saveUserData,
  required final SetSessionUseCase setSession,
  required final LogOutUseCase logOut,
});
