import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/domain/models/todo_category.dart';
import 'package:clean_architecture/ui/core/ui/base/chips/chip_row.dart';
import 'package:clean_architecture/ui/core/ui/base/chips/select_chip.dart';
import 'package:clean_architecture/ui/core/ui/base/text/section_header.dart';
import 'package:clean_architecture/ui/features/todos/models/todo_presentation.dart';
import 'package:material_ui/material_ui.dart';

class const CategoryPicker({
  super.key,
  required final TodoCategory selected,
  required final ValueChanged<TodoCategory> onSelected,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .stretch,
      children: [
        const SectionHeader(title: TodoMessages.category),
        ChipRow(
          wrap: true,
          children: [
            for (final category in TodoCategory.values)
              SelectChip(
                label: category.label,
                icon: category.icon,
                selected: category == selected,
                onSelected: () => onSelected(category),
              ),
          ],
        ),
      ],
    );
  }
}
