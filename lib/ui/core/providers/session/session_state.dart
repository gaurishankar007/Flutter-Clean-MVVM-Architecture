import 'package:clean_architecture/domain/models/user.dart';
import 'package:clean_architecture/ui/core/providers/base/base_notifier.dart';

final class const SessionState({
  final User? user,

  /// Set when the session expired; the root widget sends the user to login.
  final bool expired = false,
  super.message,
}) extends BaseState {
  bool get isLoggedIn => user != null;

  @override
  List<Object?> get props => [...super.props, user, expired];
}
