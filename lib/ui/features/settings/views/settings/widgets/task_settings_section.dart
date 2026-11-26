import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/ui/core/providers/settings/app_settings_notifier.dart';
import 'package:clean_architecture/ui/core/ui/base/dialog/confirm_dialog.dart';
import 'package:clean_architecture/ui/features/settings/providers/settings/settings_notifier.dart';
import 'package:clean_architecture/ui/features/settings/widgets/settings_section.dart';
import 'package:clean_architecture/ui/features/settings/widgets/settings_switch_tile.dart';
import 'package:clean_architecture/ui/features/settings/widgets/settings_tile.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';

class const TaskSettingsSection({super.key}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dueReminders = ref.watch(
      appSettingsProvider.select((state) => state.settings.dueReminders),
    );
    return SettingsSection(
      title: SettingsMessages.tasks,
      children: [
        SettingsSwitchTile(
          icon: Symbols.notifications_active_rounded,
          title: SettingsMessages.dueReminders,
          subtitle: SettingsMessages.dueRemindersBody,
          value: dueReminders,
          onChanged: ref.read(appSettingsProvider.notifier).setDueReminders,
        ),
        SettingsTile(
          icon: Symbols.delete_sweep_rounded,
          title: SettingsMessages.clearCompleted,
          subtitle: SettingsMessages.clearCompletedBody,
          onTap: () async {
            final confirmed = await showConfirmDialog(
              context,
              title: SettingsMessages.clearCompletedTitle,
              body: SettingsMessages.clearCompletedBody,
              confirmLabel: CommonMessages.delete,
              destructive: true,
            );
            if (confirmed) {
              await ref.read(settingsProvider.notifier).clearCompleted();
            }
          },
        ),
      ],
    );
  }
}
