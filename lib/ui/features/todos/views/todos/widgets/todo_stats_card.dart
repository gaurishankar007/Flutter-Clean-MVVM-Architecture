import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/ui/core/themes/app_spacing.dart';
import 'package:clean_architecture/ui/core/themes/theme.dart';
import 'package:clean_architecture/ui/core/ui/base/cards/app_card.dart';
import 'package:clean_architecture/ui/core/ui/base/cards/stat_tile.dart';
import 'package:clean_architecture/ui/core/ui/base/progress/progress_ring.dart';
import 'package:clean_architecture/ui/features/todos/providers/todos/todos_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

/// Today's progress ring and counts for today, overdue and completed.
class const TodoStatsCard({super.key}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(todosProvider.select((state) => state.stats));
    return AppCard(
      child: Column(
        spacing: AppSpacing.lg,
        children: [
          Row(
            spacing: AppSpacing.lg,
            children: [
              ProgressRing(
                value: stats.todayProgress,
                child: Text(
                  '${(stats.todayProgress * 100).round()}%',
                  style: context.text.numeric.copyWith(fontSize: 15),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  spacing: AppSpacing.xs,
                  children: [
                    Text(
                      TodoMessages.progressTitle,
                      style: context.text.headline,
                    ),
                    Text(
                      TodoMessages.progressBody(
                        stats.doneToday,
                        stats.dueToday,
                      ),
                      style: context.text.label.copyWith(
                        color: context.colors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            spacing: AppSpacing.sm,
            children: [
              Expanded(
                child: StatTile(
                  label: TodoMessages.statToday,
                  value: stats.dueToday,
                  color: context.colors.primaryText,
                ),
              ),
              Expanded(
                child: StatTile(
                  label: TodoMessages.statOverdue,
                  value: stats.overdue,
                  color: context.colors.error,
                ),
              ),
              Expanded(
                child: StatTile(
                  label: TodoMessages.statCompleted,
                  value: stats.completed,
                  color: context.colors.success,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
