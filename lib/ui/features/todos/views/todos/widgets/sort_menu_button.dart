import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/domain/models/todo_query.dart';
import 'package:clean_architecture/ui/core/themes/app_spacing.dart';
import 'package:clean_architecture/ui/core/themes/theme.dart';
import 'package:clean_architecture/ui/core/ui/base/buttons/app_icon_button.dart';
import 'package:clean_architecture/ui/features/todos/models/todo_presentation.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';

/// Opens the sort options; the current one is checked.
class const SortMenuButton({
  super.key,
  required final TodoSort selected,
  required final ValueChanged<TodoSort> onSelected,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      style: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(context.colors.surface),
        shape: const WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: AppRadius.lgAll),
        ),
      ),
      menuChildren: [
        for (final sort in TodoSort.values)
          MenuItemButton(
            leadingIcon: Icon(sort.icon, size: 18),
            trailingIcon: sort == selected
                ? Icon(
                    Symbols.check_rounded,
                    size: 18,
                    color: context.colors.primaryText,
                  )
                : null,
            onPressed: () => onSelected(sort),
            child: Padding(
              padding: const .only(right: AppSpacing.lg),
              child: Text(sort.label, style: context.text.body),
            ),
          ),
      ],
      builder: (context, controller, _) => AppIconButton(
        icon: Symbols.sort_rounded,
        label: TodoMessages.sortBy,
        onPressed: () =>
            controller.isOpen ? controller.close() : controller.open(),
      ),
    );
  }
}
