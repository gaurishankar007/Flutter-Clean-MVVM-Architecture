import 'package:clean_architecture/ui/core/ui/base/cards/app_card.dart';
import 'package:clean_architecture/ui/core/ui/base/text/section_header.dart';
import 'package:material_ui/material_ui.dart';

/// A titled card of settings tiles, separated by dividers.
class const SettingsSection({
  super.key,
  required final String title,
  required final List<Widget> children,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .stretch,
      children: [
        SectionHeader(title: title),
        AppCard(
          padding: .zero,
          child: Column(
            children: [
              for (final (index, child) in children.indexed) ...[
                if (index > 0) const Divider(indent: 68),
                child,
              ],
            ],
          ),
        ),
      ],
    );
  }
}
