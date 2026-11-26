import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/core/utils/debouncer.dart';
import 'package:clean_architecture/ui/core/themes/app_spacing.dart';
import 'package:clean_architecture/ui/core/themes/theme.dart';
import 'package:clean_architecture/ui/core/ui/base/form/app_text_field.dart';
import 'package:clean_architecture/ui/features/todos/providers/todos/todos_notifier.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';

/// Searches titles, notes and subtasks, debounced.
class const TodoSearchField({super.key}) extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(todosProvider.notifier);
    final controller = useTextEditingController(
      text: ref.read(todosProvider).query.search,
    );
    final debouncer = useMemoized(Debouncer.new);
    useEffect(() => debouncer.dispose, [debouncer]);
    final hasText = useListenableSelector(
      controller,
      () => controller.text.isNotEmpty,
    );

    return Padding(
      padding: const .only(top: AppSpacing.lg),
      child: AppTextField(
        controller: controller,
        hint: TodoMessages.searchHint,
        icon: Symbols.search_rounded,
        textInputAction: .search,
        onChanged: (text) => debouncer.run(() => notifier.setSearch(text)),
        trailing: hasText
            ? IconButton(
                tooltip: TodoMessages.clearSearch,
                icon: Icon(
                  Symbols.close_rounded,
                  size: 20,
                  color: context.colors.textMuted,
                ),
                onPressed: () {
                  controller.clear();
                  notifier.setSearch('');
                },
              )
            : null,
      ),
    );
  }
}
