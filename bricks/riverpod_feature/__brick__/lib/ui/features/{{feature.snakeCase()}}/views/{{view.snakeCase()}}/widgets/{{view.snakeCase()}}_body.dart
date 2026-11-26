import 'package:clean_architecture/ui/features/{{feature.snakeCase()}}/providers/{{notifier.snakeCase()}}/{{notifier.snakeCase()}}_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

class const {{view.pascalCase()}}Body({super.key}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Scaffold: build the body from it.
    // ignore: unused_local_variable
    final state = ref.watch({{notifier.camelCase()}}Provider);
    return const SizedBox.shrink();
  }
}
