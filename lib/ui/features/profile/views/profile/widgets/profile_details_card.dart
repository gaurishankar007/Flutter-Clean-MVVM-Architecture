import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/domain/models/user.dart';
import 'package:clean_architecture/ui/core/ui/base/cards/app_card.dart';
import 'package:clean_architecture/ui/core/ui/base/text/info_row.dart';
import 'package:clean_architecture/ui/core/ui/base/text/section_header.dart';
import 'package:material_ui/material_ui.dart';

class const ProfileDetailsCard({super.key, required final User user})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .stretch,
      children: [
        const SectionHeader(title: ProfileMessages.title),
        AppCard(
          child: Column(
            children: [
              InfoRow(label: ProfileMessages.username, value: user.username),
              InfoRow(label: ProfileMessages.email, value: user.email),
              InfoRow(
                label: ProfileMessages.phone,
                value: user.phone ?? ProfileMessages.notSet,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
