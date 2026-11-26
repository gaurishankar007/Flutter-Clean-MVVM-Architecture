import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/ui/core/themes/theme_data.dart';
import 'package:clean_architecture/ui/core/ui/base/buttons/gradient_button.dart';
import 'package:clean_architecture/ui/core/ui/base/states/empty_state.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';

/// Shown instead of the app when startup fails.
class const StartupErrorApp({
  super.key,
  required final Future<void> Function() onRetry,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: buildTheme(.light),
      darkTheme: buildTheme(.dark),
      home: Scaffold(
        body: Center(
          child: EmptyState(
            icon: Symbols.error_rounded,
            title: StartupMessages.startupFailedTitle,
            body: StartupMessages.startupFailedBody,
            action: GradientButton(
              label: CommonMessages.retry,
              onPressed: onRetry,
            ),
          ),
        ),
      ),
    );
  }
}
