import 'package:auto_route/auto_route.dart';
import 'package:clean_architecture/ui/core/ui/base/layout/aurora_glow.dart';
import 'package:clean_architecture/ui/core/ui/base/layout/screen_scroll_view.dart';
import 'package:clean_architecture/ui/core/utils/extensions/ref_extension.dart';
import 'package:clean_architecture/ui/features/auth/providers/login/login_notifier.dart';
import 'package:clean_architecture/ui/features/auth/views/login/widgets/login_form.dart';
import 'package:clean_architecture/ui/features/auth/views/login/widgets/login_header.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

@RoutePage()
class const LoginScreen({super.key}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listenMessages(loginProvider, context);
    return const Scaffold(
      body: ScreenScrollView(
        background: AuroraGlow(),
        children: [LoginHeader(), LoginForm()],
      ),
    );
  }
}
