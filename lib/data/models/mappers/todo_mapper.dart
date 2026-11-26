import 'dart:convert';

import 'package:clean_architecture/core/clients/database/app_database.dart';
import 'package:clean_architecture/domain/models/subtask.dart';
import 'package:clean_architecture/domain/models/todo.dart';
import 'package:clean_architecture/domain/models/todo_category.dart';
import 'package:clean_architecture/domain/models/todo_priority.dart';
import 'package:drift/drift.dart';

extension TodoRowMapper on TodoLocalData {
  Todo toDomain() => Todo(
    id: id,
    remoteId: remoteId,
    title: title,
    notes: notes,
    isCompleted: isCompleted,
    priority: TodoPriority.values.asNameMap()[priority] ?? .medium,
    category: TodoCategory.values.asNameMap()[category] ?? .other,
    dueAt: dueAt,
    completedAt: completedAt,
    subtasks: [
      for (final item in jsonDecode(subtasks) as List<dynamic>)
        if (item case {
          'id': final String id,
          'title': final String title,
          'isDone': final bool isDone,
        })
          Subtask(id: id, title: title, isDone: isDone),
    ],
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}

extension TodoCompanionMapper on Todo {
  TodoLocalCompanion toCompanion() => TodoLocalCompanion(
    id: Value(id),
    remoteId: Value(remoteId),
    title: Value(title),
    notes: Value(notes),
    isCompleted: Value(isCompleted),
    priority: Value(priority.name),
    category: Value(category.name),
    dueAt: Value(dueAt),
    completedAt: Value(completedAt),
    subtasks: Value(
      jsonEncode([
        for (final subtask in subtasks)
          <String, dynamic>{
            'id': subtask.id,
            'title': subtask.title,
            'isDone': subtask.isDone,
          },
      ]),
    ),
    createdAt: Value(createdAt),
    updatedAt: Value(updatedAt),
  );
}
