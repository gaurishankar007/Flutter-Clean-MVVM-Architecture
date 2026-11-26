import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/ui/core/themes/app_spacing.dart';
import 'package:clean_architecture/ui/core/themes/theme.dart';
import 'package:clean_architecture/ui/core/ui/base/buttons/ghost_button.dart';
import 'package:clean_architecture/ui/core/ui/base/cards/app_card.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';

/// The demo backend's public test account, with a button to fill it in.
class const DemoAccountCard({super.key, required final VoidCallback onUse})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const .fromLTRB(
        AppSpacing.lg,
        AppSpacing.sm,
        AppSpacing.sm,
        AppSpacing.sm,
      ),
      child: Row(
        spacing: AppSpacing.md,
        children: [
          Icon(Symbols.info_rounded, color: context.colors.secondary, size: 20),
          Expanded(
            child: Text(
              AuthMessages.demoHint,
              style: context.text.label.copyWith(
                color: context.colors.textSecondary,
              ),
            ),
          ),
          GhostButton(label: AuthMessages.useDemo, onPressed: onUse),
        ],
      ),
    );
  }
}
