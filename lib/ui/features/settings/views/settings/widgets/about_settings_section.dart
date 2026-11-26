import 'package:auto_route/auto_route.dart';
import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/routing/routes.gr.dart';
import 'package:clean_architecture/ui/core/themes/theme.dart';
import 'package:clean_architecture/ui/features/settings/providers/settings/settings_notifier.dart';
import 'package:clean_architecture/ui/features/settings/widgets/settings_section.dart';
import 'package:clean_architecture/ui/features/settings/widgets/settings_tile.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';

class const AboutSettingsSection({super.key}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final version = ref.watch(
      settingsProvider.select((state) => state.version),
    );
    return SettingsSection(
      title: SettingsMessages.about,
      children: [
        SettingsTile(
          icon: Symbols.info_rounded,
          title: SettingsMessages.version,
          trailing: Text(
            version ?? '',
            style: context.text.numeric.copyWith(
              color: context.colors.textSecondary,
            ),
          ),
        ),
        SettingsTile(
          icon: Symbols.bug_report_rounded,
          title: SettingsMessages.errorLog,
          subtitle: SettingsMessages.errorLogBody,
          onTap: () => context.router.push(const ErrorLogRoute()),
        ),
      ],
    );
  }
}
