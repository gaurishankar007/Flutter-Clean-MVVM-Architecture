import 'package:clean_architecture/domain/models/todo_priority.dart';
import 'package:clean_architecture/ui/core/themes/theme.dart';
import 'package:clean_architecture/ui/core/ui/base/badges/tag_chip.dart';
import 'package:clean_architecture/ui/features/todos/models/todo_presentation.dart';
import 'package:material_ui/material_ui.dart';

class const PriorityTag({super.key, required final TodoPriority priority})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) => TagChip(
    label: priority.label,
    icon: priority.icon,
    color: priority.color(context.colors),
  );
}
