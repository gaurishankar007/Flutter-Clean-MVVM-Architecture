import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/domain/models/subtask.dart';
import 'package:clean_architecture/ui/core/themes/theme.dart';
import 'package:clean_architecture/ui/core/ui/base/buttons/app_icon_button.dart';
import 'package:clean_architecture/ui/core/ui/base/form/app_checkbox.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';

/// A checklist row; [onRemove] adds a remove button (editor).
class const SubtaskTile({
  super.key,
  required final Subtask subtask,
  required final VoidCallback onToggle,
  final VoidCallback? onRemove,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppCheckbox(
          value: subtask.isDone,
          size: 20,
          label: subtask.title,
          onChanged: (_) => onToggle(),
        ),
        Expanded(
          child: Text(
            subtask.title,
            style: context.text.body.copyWith(
              color: subtask.isDone ? context.colors.textMuted : null,
              decoration: subtask.isDone ? .lineThrough : null,
            ),
          ),
        ),
        if (onRemove != null)
          AppIconButton(
            icon: Symbols.close_rounded,
            label: TodoMessages.removeSubtask,
            size: 32,
            onPressed: onRemove,
          ),
      ],
    );
  }
}
