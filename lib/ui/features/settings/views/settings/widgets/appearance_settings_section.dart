import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/ui/core/providers/settings/app_settings_notifier.dart';
import 'package:clean_architecture/ui/features/settings/views/settings/widgets/theme_mode_picker.dart';
import 'package:clean_architecture/ui/features/settings/widgets/settings_section.dart';
import 'package:clean_architecture/ui/features/settings/widgets/settings_tile.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';

class const AppearanceSettingsSection({super.key}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(
      appSettingsProvider.select((state) => state.settings.themeMode),
    );
    return SettingsSection(
      title: SettingsMessages.appearance,
      children: [
        SettingsTile(
          icon: Symbols.palette_rounded,
          title: SettingsMessages.theme,
          below: ThemeModePicker(
            selected: themeMode,
            onSelected: ref.read(appSettingsProvider.notifier).setThemeMode,
          ),
        ),
      ],
    );
  }
}
