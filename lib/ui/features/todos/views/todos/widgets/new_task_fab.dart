import 'package:auto_route/auto_route.dart';
import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/routing/routes.gr.dart';
import 'package:clean_architecture/ui/core/themes/app_spacing.dart';
import 'package:clean_architecture/ui/core/ui/base/buttons/gradient_button.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';

/// "New task", floating above the bottom bar.
class const NewTaskFab({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // The shell's Scaffold (extendBody) reports the floating bar's height.
    final bottom = MediaQuery.paddingOf(context).bottom;
    return Positioned(
      right: AppSpacing.lg,
      bottom: bottom + AppSpacing.lg,
      child: GradientButton(
        label: TodoMessages.newTask,
        icon: Symbols.add_rounded,
        onPressed: () => context.router.push(TodoEditorRoute()),
      ),
    );
  }
}
