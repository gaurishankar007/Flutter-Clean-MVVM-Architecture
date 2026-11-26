import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/ui/core/themes/theme.dart';
import 'package:clean_architecture/ui/core/ui/base/cards/app_card.dart';
import 'package:clean_architecture/ui/core/ui/base/text/section_header.dart';
import 'package:material_ui/material_ui.dart';

class const TodoNotesCard({super.key, required final String notes})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .stretch,
      children: [
        const SectionHeader(title: TodoMessages.notes),
        AppCard(
          child: SelectableText(
            notes.isEmpty ? TodoMessages.noNotes : notes,
            style: context.text.body.copyWith(
              color: notes.isEmpty ? context.colors.textMuted : null,
            ),
          ),
        ),
      ],
    );
  }
}
