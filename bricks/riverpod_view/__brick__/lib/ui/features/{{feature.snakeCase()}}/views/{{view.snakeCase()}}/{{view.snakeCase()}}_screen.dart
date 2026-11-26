import 'package:auto_route/auto_route.dart';
import 'package:clean_architecture/ui/core/ui/base/layout/screen_back_button.dart';
import 'package:clean_architecture/ui/core/ui/base/layout/screen_header.dart';
import 'package:clean_architecture/ui/core/ui/base/layout/screen_scroll_view.dart';
import 'package:clean_architecture/ui/core/utils/extensions/ref_extension.dart';
import 'package:clean_architecture/ui/features/{{feature.snakeCase()}}/providers/{{notifier.snakeCase()}}/{{notifier.snakeCase()}}_notifier.dart';
import 'package:clean_architecture/ui/features/{{feature.snakeCase()}}/views/{{view.snakeCase()}}/widgets/{{view.snakeCase()}}_body.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

@RoutePage()
class const {{view.pascalCase()}}Screen({super.key}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listenMessages({{notifier.camelCase()}}Provider, context);
    return const Scaffold(
      body: ScreenScrollView(
        children: [
          ScreenBackButton(),
          // TODO: move the title to app_messages.dart.
          ScreenHeader(title: '{{view.pascalCase()}}'),
          {{view.pascalCase()}}Body(),
        ],
      ),
    );
  }
}
