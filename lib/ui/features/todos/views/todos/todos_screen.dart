import 'package:auto_route/auto_route.dart';
import 'package:clean_architecture/ui/core/ui/base/layout/aurora_glow.dart';
import 'package:clean_architecture/ui/core/ui/base/layout/screen_scroll_view.dart';
import 'package:clean_architecture/ui/core/utils/extensions/ref_extension.dart';
import 'package:clean_architecture/ui/features/todos/providers/todos/todos_notifier.dart';
import 'package:clean_architecture/ui/features/todos/views/todos/widgets/new_task_fab.dart';
import 'package:clean_architecture/ui/features/todos/views/todos/widgets/todo_filter_bar.dart';
import 'package:clean_architecture/ui/features/todos/views/todos/widgets/todo_list_body.dart';
import 'package:clean_architecture/ui/features/todos/views/todos/widgets/todo_search_field.dart';
import 'package:clean_architecture/ui/features/todos/views/todos/widgets/todo_stats_card.dart';
import 'package:clean_architecture/ui/features/todos/views/todos/widgets/todos_header.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

/// The Tasks tab.
@RoutePage()
class const TodosScreen({super.key}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listenMessages(todosProvider, context);
    return Stack(
      children: [
        ScreenScrollView(
          background: const AuroraGlow(),
          onRefresh: ref.read(todosProvider.notifier).sync,
          children: const [
            TodosHeader(),
            TodoStatsCard(),
            TodoSearchField(),
            TodoFilterBar(),
            TodoListBody(),
            // Room for the FAB over the last card.
            SizedBox(height: 72),
          ],
        ),
        const NewTaskFab(),
      ],
    );
  }
}
