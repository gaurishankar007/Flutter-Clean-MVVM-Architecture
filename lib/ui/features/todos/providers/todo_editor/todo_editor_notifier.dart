import 'package:clean_architecture/core/data/states/data_state.dart';
import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/core/utils/extensions/datetime_extension.dart';
import 'package:clean_architecture/domain/models/subtask.dart';
import 'package:clean_architecture/domain/models/todo.dart';
import 'package:clean_architecture/domain/models/todo_category.dart';
import 'package:clean_architecture/domain/models/todo_priority.dart';
import 'package:clean_architecture/domain/repositories/todo_repository.dart';
import 'package:clean_architecture/domain/use_cases/save_todo_use_case.dart';
import 'package:clean_architecture/ui/core/providers/base/base_notifier.dart';
import 'package:clean_architecture/ui/features/todos/providers/todo_editor/todo_editor_state.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

/// Creates a task ([todoId] null) or edits one.
class TodoEditorNotifier(final String? todoId)
    extends BaseNotifier<TodoEditorState> {
  static const maxTitleLength = 120;

  @override
  TodoEditorState build() {
    if (todoId case final id?) {
      Future.microtask(() => _load(id));
      return const TodoEditorState();
    }
    return const TodoEditorState(status: .loaded);
  }

  Future<void> _load(String id) => runFlow('todoEditor.load', () async {
    final result = await GetIt.I<TodoRepository>().getTodo(id);
    if (!ref.mounted) {
      return;
    }
    state = switch (result) {
      SuccessState(data: final todo?) => TodoEditorState(
        status: .loaded,
        original: todo,
        title: todo.title,
        notes: todo.notes,
        priority: todo.priority,
        category: todo.category,
        dueAt: todo.dueAt,
        subtasks: todo.subtasks,
      ),
      SuccessState() => TodoEditorState(
        status: .error,
        message: trackError(TodoMessages.notFound),
      ),
      _ => TodoEditorState(status: .error, message: trackFailure(result)),
    };
  });

  void setTitle(String title) =>
      state = state.copyWith(title: title, clearTitleError: true);

  void setNotes(String notes) => state = state.copyWith(notes: notes);

  void setPriority(TodoPriority priority) =>
      state = state.copyWith(priority: priority);

  void setCategory(TodoCategory category) =>
      state = state.copyWith(category: category);

  /// Keeps the time already set when only the day changes.
  void setDueDate(DateTime date) {
    final time = state.dueAt;
    state = state.copyWith(
      dueAt: DateTime(
        date.year,
        date.month,
        date.day,
        time?.hour ?? 0,
        time?.minute ?? 0,
      ),
    );
  }

  /// A time needs a day: today when none is set.
  void setDueTime(int hour, int minute) {
    final day = (state.dueAt ?? DateTime.now()).dateOnly;
    state = state.copyWith(
      dueAt: day.add(Duration(hours: hour, minutes: minute)),
    );
  }

  void clearDueDate() => state = state.copyWith(clearDueAt: true);

  void addSubtask(String title) {
    final text = title.trim();
    if (text.isEmpty) {
      return;
    }
    state = state.copyWith(
      subtasks: [
        ...state.subtasks,
        Subtask(id: const Uuid().v4(), title: text),
      ],
    );
  }

  void removeSubtask(String id) => state = state.copyWith(
    subtasks: [
      for (final s in state.subtasks)
        if (s.id != id) s,
    ],
  );

  void toggleSubtask(String id) => state = state.copyWith(
    subtasks: [
      for (final s in state.subtasks)
        if (s.id == id) s.copyWith(isDone: !s.isDone) else s,
    ],
  );

  /// Validates and saves. Returns the saved task's id, or null; the View
  /// navigates.
  Future<String?> save() => runFlow('todoEditor.save', () async {
    if (state.isSaving) {
      return null;
    }
    final title = state.title.trim();
    final titleError = switch (title) {
      '' => ValidationMessages.required,
      _ when title.length > maxTitleLength => ValidationMessages.titleTooLong,
      _ => null,
    };
    if (titleError != null) {
      state = state.copyWith(titleError: titleError);
      return null;
    }

    final now = DateTime.now();
    final todo = switch (state.original) {
      null => Todo(
        id: const Uuid().v4(),
        title: title,
        notes: state.notes.trim(),
        priority: state.priority,
        category: state.category,
        dueAt: state.dueAt,
        subtasks: state.subtasks,
        createdAt: now,
        updatedAt: now,
      ),
      final original => original.copyWith(
        title: title,
        notes: state.notes.trim(),
        priority: state.priority,
        category: state.category,
        dueAt: state.dueAt,
        clearDueAt: state.dueAt == null,
        subtasks: state.subtasks,
        updatedAt: now,
      ),
    };

    state = state.copyWith(isSaving: true);
    final result = await GetIt.I<SaveTodoUseCase>()((
      todo: todo,
      isNew: state.isNew,
    ));
    if (!ref.mounted) {
      return null;
    }
    if (result is SuccessState) {
      state = state.copyWith(isSaving: false, original: todo);
      return todo.id;
    }
    state = state.copyWith(isSaving: false, message: trackFailure(result));
    return null;
  });
}

final todoEditorProvider = NotifierProvider.autoDispose
    .family<TodoEditorNotifier, TodoEditorState, String?>(
      TodoEditorNotifier.new,
    );
