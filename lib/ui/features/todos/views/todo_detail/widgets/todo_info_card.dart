import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/core/utils/extensions/datetime_extension.dart';
import 'package:clean_architecture/domain/models/todo.dart';
import 'package:clean_architecture/ui/core/ui/base/cards/app_card.dart';
import 'package:clean_architecture/ui/core/ui/base/text/info_row.dart';
import 'package:clean_architecture/ui/core/ui/base/text/section_header.dart';
import 'package:clean_architecture/ui/core/utils/date_formats.dart';
import 'package:material_ui/material_ui.dart';

/// Due, created and updated times.
class const TodoInfoCard({super.key, required final Todo todo})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .stretch,
      children: [
        const SectionHeader(title: TodoMessages.details),
        AppCard(
          child: Column(
            children: [
              InfoRow(
                label: TodoMessages.dueDate,
                value: switch (todo.dueAt) {
                  final due? when due.hasTime => DateFormats.dateTime(due),
                  final due? => DateFormats.date(due),
                  null => TodoMessages.noDueDate,
                },
              ),
              InfoRow(
                label: TodoMessages.created,
                value: DateFormats.dateTime(todo.createdAt),
              ),
              InfoRow(
                label: TodoMessages.updated,
                value: DateFormats.dateTime(todo.updatedAt),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
