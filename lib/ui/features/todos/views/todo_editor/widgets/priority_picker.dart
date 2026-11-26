import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/domain/models/todo_priority.dart';
import 'package:clean_architecture/ui/core/ui/base/form/segmented_picker.dart';
import 'package:clean_architecture/ui/core/ui/base/text/section_header.dart';
import 'package:clean_architecture/ui/features/todos/models/todo_presentation.dart';
import 'package:material_ui/material_ui.dart';

class const PriorityPicker({
  super.key,
  required final TodoPriority selected,
  required final ValueChanged<TodoPriority> onSelected,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .stretch,
      children: [
        const SectionHeader(title: TodoMessages.priority),
        SegmentedPicker<TodoPriority>(
          segments: [
            for (final priority in TodoPriority.values)
              (value: priority, label: priority.label, icon: priority.icon),
          ],
          selected: selected,
          onSelected: onSelected,
        ),
      ],
    );
  }
}
