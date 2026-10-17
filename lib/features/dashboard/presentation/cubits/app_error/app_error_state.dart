part of 'app_error_cubit.dart';

class const AppErrorState({
  super.status,
  final List<AppErrorDetails> errors = const [],
}) extends BaseState {
  factory initial() => const AppErrorState();

  AppErrorState copyWith({StateStatus? status, List<AppErrorDetails>? errors}) {
    return AppErrorState(
      status: status ?? this.status,
      errors: errors ?? this.errors,
    );
  }

  @override
  List<Object?> get props => [status, errors];
}
