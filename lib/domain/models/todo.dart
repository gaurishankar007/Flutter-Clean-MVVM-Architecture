import 'package:clean_architecture/core/utils/extensions/datetime_extension.dart';
import 'package:clean_architecture/domain/models/subtask.dart';
import 'package:clean_architecture/domain/models/todo_category.dart';
import 'package:clean_architecture/domain/models/todo_priority.dart';
import 'package:equatable/equatable.dart';

/// A task.
final class const Todo({
  required final String id,
  required final String title,
  required final DateTime createdAt,
  required final DateTime updatedAt,
  final String notes = '',
  final bool isCompleted = false,
  final TodoPriority priority = .medium,
  final TodoCategory category = .personal,

  /// When it's due; a midnight time means "the whole day".
  final DateTime? dueAt,
  final DateTime? completedAt,
  final List<Subtask> subtasks = const [],

  /// The id on the server, for tasks imported by a sync.
  final int? remoteId,
}) extends Equatable {
  bool isOverdue([DateTime? now]) {
    final due = dueAt;
    if (isCompleted || due == null) {
      return false;
    }
    final current = now ?? DateTime.now();
    // An all-day task is overdue only once its day has passed.
    return due.hasTime ? due.isBefore(current) : due.daysFromToday(current) < 0;
  }

  bool isDueToday([DateTime? now]) =>
      dueAt != null && dueAt!.daysFromToday(now) == 0;

  int get completedSubtasks => subtasks.where((s) => s.isDone).length;

  /// 0–1; tasks without subtasks count as 0 or 1 by [isCompleted].
  double get progress => subtasks.isEmpty
      ? (isCompleted ? 1 : 0)
      : completedSubtasks / subtasks.length;

  Todo copyWith({
    String? title,
    String? notes,
    bool? isCompleted,
    TodoPriority? priority,
    TodoCategory? category,
    DateTime? dueAt,
    bool clearDueAt = false,
    DateTime? completedAt,
    bool clearCompletedAt = false,
    List<Subtask>? subtasks,
    DateTime? updatedAt,
  }) => Todo(
    id: id,
    remoteId: remoteId,
    createdAt: createdAt,
    title: title ?? this.title,
    notes: notes ?? this.notes,
    isCompleted: isCompleted ?? this.isCompleted,
    priority: priority ?? this.priority,
    category: category ?? this.category,
    dueAt: clearDueAt ? null : dueAt ?? this.dueAt,
    completedAt: clearCompletedAt ? null : completedAt ?? this.completedAt,
    subtasks: subtasks ?? this.subtasks,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  @override
  List<Object?> get props => [
    id,
    title,
    notes,
    isCompleted,
    priority,
    category,
    dueAt,
    completedAt,
    subtasks,
    createdAt,
    updatedAt,
    remoteId,
  ];
}
