import 'package:clean_architecture/domain/models/subtask.dart';
import 'package:clean_architecture/domain/models/todo.dart';
import 'package:clean_architecture/domain/models/todo_category.dart';
import 'package:clean_architecture/domain/models/todo_priority.dart';
import 'package:clean_architecture/ui/core/providers/base/base_notifier.dart';

/// The task being written. [original] is null for a new task.
final class const TodoEditorState({
  super.status = .loading,
  super.message,
  final Todo? original,
  final String title = '',
  final String notes = '',
  final TodoPriority priority = .medium,
  final TodoCategory category = .personal,
  final DateTime? dueAt,
  final List<Subtask> subtasks = const [],
  final String? titleError,
  final bool isSaving = false,
}) extends BaseState {
  bool get isNew => original == null;

  /// Whether leaving would lose edits.
  bool get hasChanges => switch (original) {
    null =>
      title.trim().isNotEmpty || notes.trim().isNotEmpty || subtasks.isNotEmpty,
    final todo =>
      todo.title != title.trim() ||
          todo.notes != notes.trim() ||
          todo.priority != priority ||
          todo.category != category ||
          todo.dueAt != dueAt ||
          todo.subtasks != subtasks,
  };

  TodoEditorState copyWith({
    StateStatus? status,
    StateMessage? message,
    Todo? original,
    String? title,
    String? notes,
    TodoPriority? priority,
    TodoCategory? category,
    DateTime? dueAt,
    bool clearDueAt = false,
    List<Subtask>? subtasks,
    String? titleError,
    bool clearTitleError = false,
    bool? isSaving,
  }) => TodoEditorState(
    status: status ?? this.status,
    message: message,
    original: original ?? this.original,
    title: title ?? this.title,
    notes: notes ?? this.notes,
    priority: priority ?? this.priority,
    category: category ?? this.category,
    dueAt: clearDueAt ? null : dueAt ?? this.dueAt,
    subtasks: subtasks ?? this.subtasks,
    titleError: clearTitleError ? null : titleError ?? this.titleError,
    isSaving: isSaving ?? this.isSaving,
  );

  @override
  List<Object?> get props => [
    ...super.props,
    original,
    title,
    notes,
    priority,
    category,
    dueAt,
    subtasks,
    titleError,
    isSaving,
  ];
}
