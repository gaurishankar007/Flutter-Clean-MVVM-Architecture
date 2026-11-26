import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/ui/core/themes/app_spacing.dart';
import 'package:clean_architecture/ui/core/themes/theme.dart';
import 'package:clean_architecture/ui/core/ui/base/cards/stat_tile.dart';
import 'package:clean_architecture/ui/core/ui/base/text/section_header.dart';
import 'package:clean_architecture/ui/features/todos/providers/todos/todos_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

/// Total, done and open task counts.
class const ProfileStatsRow({super.key}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(todosProvider.select((state) => state.stats));
    final colors = context.colors;
    return Column(
      crossAxisAlignment: .stretch,
      children: [
        const SectionHeader(title: ProfileMessages.statsTitle),
        Row(
          spacing: AppSpacing.sm,
          children: [
            Expanded(
              child: StatTile(
                label: ProfileMessages.statTotal,
                value: stats.total,
                color: colors.primaryText,
              ),
            ),
            Expanded(
              child: StatTile(
                label: ProfileMessages.statDone,
                value: stats.completed,
                color: colors.success,
              ),
            ),
            Expanded(
              child: StatTile(
                label: ProfileMessages.statOpen,
                value: stats.open,
                color: colors.warning,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
