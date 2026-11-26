import 'package:clean_architecture/ui/core/providers/base/base_notifier.dart';

final class const LoginState({
  super.status,
  super.message,
  final String? usernameError,
  final String? passwordError,
}) extends BaseState {
  @override
  List<Object?> get props => [...super.props, usernameError, passwordError];
}
