import 'package:clean_architecture/domain/models/todo_category.dart';
import 'package:clean_architecture/domain/models/todo_query.dart';
import 'package:clean_architecture/ui/core/themes/app_spacing.dart';
import 'package:clean_architecture/ui/core/ui/base/chips/chip_row.dart';
import 'package:clean_architecture/ui/core/ui/base/chips/select_chip.dart';
import 'package:clean_architecture/ui/features/todos/models/todo_presentation.dart';
import 'package:clean_architecture/ui/features/todos/providers/todos/todos_notifier.dart';
import 'package:clean_architecture/ui/features/todos/views/todos/widgets/category_filter_chip.dart';
import 'package:clean_architecture/ui/features/todos/views/todos/widgets/sort_menu_button.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

/// Filter chips, the sort menu, and category chips.
class const TodoFilterBar({super.key}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(todosProvider.select((state) => state.query));
    final notifier = ref.read(todosProvider.notifier);
    return Padding(
      padding: const .only(top: AppSpacing.md),
      child: Column(
        crossAxisAlignment: .stretch,
        spacing: AppSpacing.sm,
        children: [
          Row(
            spacing: AppSpacing.sm,
            children: [
              Expanded(
                child: ChipRow(
                  children: [
                    for (final filter in TodoFilter.values)
                      SelectChip(
                        label: filter.label,
                        selected: query.filter == filter,
                        onSelected: () => notifier.setFilter(filter),
                      ),
                  ],
                ),
              ),
              SortMenuButton(
                selected: query.sort,
                onSelected: notifier.setSort,
              ),
            ],
          ),
          ChipRow(
            children: [
              for (final category in TodoCategory.values)
                CategoryFilterChip(
                  category: category,
                  selected: query.category == category,
                  onSelected: () => notifier.toggleCategory(category),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
