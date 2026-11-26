import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';

/// The tabs, in order. Index matches the AutoTabsRouter routes.
enum NavDestination {
  tasks(Symbols.task_alt_rounded, NavMessages.tasks),
  notifications(Symbols.notifications_rounded, NavMessages.notifications),
  profile(Symbols.person_rounded, NavMessages.profile),
  settings(Symbols.settings_rounded, NavMessages.settings);

  new(this.icon, this.label);

  final IconData icon;
  final String label;
}
