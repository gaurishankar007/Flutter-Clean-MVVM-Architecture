import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/domain/models/subtask.dart';
import 'package:clean_architecture/ui/core/themes/theme_data.dart';
import 'package:clean_architecture/ui/features/todos/widgets/todo_card.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:patrol_finders/patrol_finders.dart';

import '../../../../../testing/helpers/fixtures.dart';

void main() {
  patrolWidgetTest('shows the task and reports taps', ($) async {
    var tapped = false;
    bool? completed;
    await $.pumpWidget(
      MaterialApp(
        theme: buildTheme(Brightness.light),
        home: Scaffold(
          body: TodoCard(
            todo: testTodo(
              title: 'Write report',
              subtasks: const [
                Subtask(id: 'a', title: 'Draft', isDone: true),
                Subtask(id: 'b', title: 'Review'),
              ],
            ),
            onTap: () => tapped = true,
            onCompletedChanged: (value) => completed = value,
          ),
        ),
      ),
    );

    expect($('Write report'), findsOneWidget);
    expect($(TodoMessages.subtaskProgress(1, 2)), findsOneWidget);

    await $('Write report').tap();
    expect(tapped, isTrue);

    await $(Semantics)
        .which<Semantics>((w) => w.properties.label == TodoMessages.markDone)
        .tap();
    expect(completed, isTrue);
  });
}
