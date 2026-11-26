import 'package:auto_route/auto_route.dart';
import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/ui/core/ui/base/layout/screen_header.dart';
import 'package:clean_architecture/ui/core/ui/base/layout/screen_scroll_view.dart';
import 'package:clean_architecture/ui/core/utils/extensions/ref_extension.dart';
import 'package:clean_architecture/ui/features/settings/providers/settings/settings_notifier.dart';
import 'package:clean_architecture/ui/features/settings/views/settings/widgets/about_settings_section.dart';
import 'package:clean_architecture/ui/features/settings/views/settings/widgets/appearance_settings_section.dart';
import 'package:clean_architecture/ui/features/settings/views/settings/widgets/task_settings_section.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

/// The Settings tab.
@RoutePage()
class const SettingsScreen({super.key}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listenMessages(settingsProvider, context);
    return const ScreenScrollView(
      children: [
        ScreenHeader(title: SettingsMessages.title),
        AppearanceSettingsSection(),
        TaskSettingsSection(),
        AboutSettingsSection(),
      ],
    );
  }
}
