import 'package:auto_route/auto_route.dart';
import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/routing/routes.gr.dart';
import 'package:clean_architecture/ui/core/themes/app_spacing.dart';
import 'package:clean_architecture/ui/core/ui/base/buttons/app_icon_button.dart';
import 'package:clean_architecture/ui/core/ui/base/dialog/confirm_dialog.dart';
import 'package:clean_architecture/ui/core/ui/base/layout/screen_back_button.dart';
import 'package:clean_architecture/ui/core/utils/toast_util.dart';
import 'package:clean_architecture/ui/features/todos/providers/todo_detail/todo_detail_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';

/// Back, Edit and Delete.
class const TodoDetailTopBar({
  super.key,
  required final String todoId,
  required final bool canEdit,
}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> delete() async {
      final confirmed = await showConfirmDialog(
        context,
        title: TodoMessages.deleteTitle,
        body: TodoMessages.deleteBody,
        confirmLabel: CommonMessages.delete,
        destructive: true,
      );
      if (!confirmed || !context.mounted) {
        return;
      }
      final router = context.router;
      if (await ref.read(todoDetailProvider(todoId).notifier).delete() &&
          context.mounted) {
        ToastUtil.showSuccess(context, TodoMessages.deleted);
        await router.maybePop();
      }
    }

    return Row(
      children: [
        const Expanded(child: ScreenBackButton()),
        if (canEdit) ...[
          Padding(
            padding: const .only(top: AppSpacing.sm),
            child: AppIconButton(
              icon: Symbols.edit_rounded,
              label: CommonMessages.edit,
              onPressed: () =>
                  context.router.push(TodoEditorRoute(todoId: todoId)),
            ),
          ),
          Padding(
            padding: const .only(top: AppSpacing.sm),
            child: AppIconButton(
              icon: Symbols.delete_rounded,
              label: CommonMessages.delete,
              destructive: true,
              onPressed: delete,
            ),
          ),
        ],
      ],
    );
  }
}
