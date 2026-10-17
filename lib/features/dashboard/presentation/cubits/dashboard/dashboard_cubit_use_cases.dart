import 'package:clean_architecture/features/auth/domain/use_cases/check_authentication_use_case.dart';
import 'package:clean_architecture/features/auth/domain/use_cases/log_out_use_case.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class const DashboardCubitUseCases({
  required final CheckAuthenticationUseCase checkAuthentication,
  required final LogOutUseCase logOut,
});
