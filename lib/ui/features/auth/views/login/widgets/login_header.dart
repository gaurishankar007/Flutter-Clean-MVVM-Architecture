import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/ui/core/themes/app_spacing.dart';
import 'package:clean_architecture/ui/core/ui/base/icons/gradient_icon_tile.dart';
import 'package:clean_architecture/ui/core/ui/base/layout/screen_header.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';

class const LoginHeader({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: .only(top: AppSpacing.xxxl),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          GradientIconTile(icon: Symbols.task_alt_rounded, size: 64),
          ScreenHeader(
            title: AuthMessages.loginTitle,
            subtitle: AuthMessages.loginSubtitle,
            large: true,
          ),
        ],
      ),
    );
  }
}
