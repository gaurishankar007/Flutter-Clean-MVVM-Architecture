import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/core/utils/extensions/datetime_extension.dart';
import 'package:clean_architecture/ui/core/themes/app_spacing.dart';
import 'package:clean_architecture/ui/core/ui/base/buttons/app_icon_button.dart';
import 'package:clean_architecture/ui/core/ui/base/buttons/tonal_button.dart';
import 'package:clean_architecture/ui/core/ui/base/text/section_header.dart';
import 'package:clean_architecture/ui/core/utils/date_formats.dart';
import 'package:clean_architecture/ui/features/todos/providers/todo_editor/todo_editor_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';

/// Day and time buttons (opening the Material pickers) and Clear.
class const DueDatePicker({super.key, final String? todoId})
    extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = todoEditorProvider(todoId);
    final dueAt = ref.watch(provider.select((state) => state.dueAt));
    final notifier = ref.read(provider.notifier);

    Future<void> pickDate() async {
      final now = DateTime.now();
      final date = await showDatePicker(
        context: context,
        initialDate: dueAt ?? now,
        firstDate: now.subtract(const Duration(days: 365)),
        lastDate: now.add(const Duration(days: 365 * 5)),
      );
      if (date != null) {
        notifier.setDueDate(date);
      }
    }

    Future<void> pickTime() async {
      final time = await showTimePicker(
        context: context,
        initialTime: dueAt != null && dueAt.hasTime
            ? TimeOfDay.fromDateTime(dueAt)
            : const TimeOfDay(hour: 9, minute: 0),
      );
      if (time != null) {
        notifier.setDueTime(time.hour, time.minute);
      }
    }

    return Column(
      crossAxisAlignment: .stretch,
      children: [
        const SectionHeader(title: TodoMessages.dueDate),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          crossAxisAlignment: .center,
          children: [
            TonalButton(
              label: dueAt == null
                  ? TodoMessages.pickDate
                  : DateFormats.date(dueAt),
              icon: Symbols.calendar_month_rounded,
              onPressed: pickDate,
            ),
            TonalButton(
              label: dueAt != null && dueAt.hasTime
                  ? DateFormats.time(dueAt)
                  : TodoMessages.pickTime,
              icon: Symbols.schedule_rounded,
              onPressed: pickTime,
            ),
            if (dueAt != null)
              AppIconButton(
                icon: Symbols.close_rounded,
                label: TodoMessages.clearDate,
                onPressed: notifier.clearDueDate,
              ),
          ],
        ),
      ],
    );
  }
}
