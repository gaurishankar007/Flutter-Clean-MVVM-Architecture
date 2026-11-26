import 'package:clean_architecture/domain/models/todo_category.dart';
import 'package:clean_architecture/ui/core/ui/base/badges/tag_chip.dart';
import 'package:clean_architecture/ui/features/todos/models/todo_presentation.dart';
import 'package:material_ui/material_ui.dart';

class const CategoryTag({super.key, required final TodoCategory category})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) => TagChip(
    label: category.label,
    icon: category.icon,
    color: category.color,
  );
}
