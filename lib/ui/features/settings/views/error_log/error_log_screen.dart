import 'package:auto_route/auto_route.dart';
import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/ui/core/themes/app_spacing.dart';
import 'package:clean_architecture/ui/core/ui/base/buttons/ghost_button.dart';
import 'package:clean_architecture/ui/core/ui/base/layout/screen_back_button.dart';
import 'package:clean_architecture/ui/core/ui/base/layout/screen_header.dart';
import 'package:clean_architecture/ui/core/ui/base/layout/screen_scroll_view.dart';
import 'package:clean_architecture/ui/core/ui/base/states/empty_state.dart';
import 'package:clean_architecture/ui/core/utils/toast_util.dart';
import 'package:clean_architecture/ui/features/settings/providers/error_log/error_log_notifier.dart';
import 'package:clean_architecture/ui/features/settings/views/error_log/widgets/error_log_tile.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';

/// Recent errors, to copy into a bug report.
@RoutePage()
class const ErrorLogScreen({super.key}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(errorLogProvider);
    return Scaffold(
      body: ScreenScrollView(
        children: [
          const ScreenBackButton(),
          const ScreenHeader(
            title: ErrorLogMessages.title,
            subtitle: ErrorLogMessages.subtitle,
          ),
          if (state.entries.isEmpty && state.status != .loading)
            const EmptyState(
              icon: Symbols.verified_rounded,
              title: ErrorLogMessages.emptyTitle,
              body: ErrorLogMessages.emptyBody,
            )
          else ...[
            Row(
              mainAxisAlignment: .end,
              children: [
                GhostButton(
                  label: CommonMessages.copy,
                  icon: Symbols.content_copy_rounded,
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: state.report));
                    if (context.mounted) {
                      ToastUtil.showSuccess(context, CommonMessages.copied);
                    }
                  },
                ),
                GhostButton(
                  label: ErrorLogMessages.clear,
                  icon: Symbols.delete_sweep_rounded,
                  destructive: true,
                  onPressed: ref.read(errorLogProvider.notifier).clear,
                ),
              ],
            ),
            for (final (index, entry) in state.entries.indexed) ...[
              if (index > 0) const SizedBox(height: AppSpacing.sm),
              ErrorLogTile(entry: entry),
            ],
          ],
        ],
      ),
    );
  }
}
