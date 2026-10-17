part of 'login_cubit.dart';

class LoginState extends BaseState {
  const new({
    required this.passwordVisibility,
    required this.saveUserCredential,
    super.message,
  });

  const new initial() : passwordVisibility = false, saveUserCredential = false;

  final bool passwordVisibility;
  final bool saveUserCredential;

  @override
  List<Object?> get props => [passwordVisibility, saveUserCredential, message];
}
