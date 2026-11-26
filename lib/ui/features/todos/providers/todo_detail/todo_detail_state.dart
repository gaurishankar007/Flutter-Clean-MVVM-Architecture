import 'package:clean_architecture/domain/models/todo.dart';
import 'package:clean_architecture/ui/core/providers/base/base_notifier.dart';

final class const TodoDetailState({
  super.status = .loading,
  super.message,
  final Todo? todo,
  final String? errorText,
}) extends BaseState {
  TodoDetailState copyWith({
    StateStatus? status,
    StateMessage? message,
    Todo? todo,
    String? errorText,
  }) => TodoDetailState(
    status: status ?? this.status,
    message: message,
    todo: todo ?? this.todo,
    errorText: errorText ?? this.errorText,
  );

  @override
  List<Object?> get props => [...super.props, todo, errorText];
}
