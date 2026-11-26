import 'package:equatable/equatable.dart';

/// One checklist item inside a task.
final class const Subtask({
  required final String id,
  required final String title,
  final bool isDone = false,
}) extends Equatable {
  Subtask copyWith({String? title, bool? isDone}) => Subtask(
    id: id,
    title: title ?? this.title,
    isDone: isDone ?? this.isDone,
  );

  @override
  List<Object?> get props => [id, title, isDone];
}
