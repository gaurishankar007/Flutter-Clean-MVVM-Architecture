import 'package:clean_architecture/core/constants/app_colors.dart';
import 'package:clean_architecture/shared_ui/ui/base/text/base_text.dart';
import 'package:clean_architecture/shared_ui/utils/ui_helpers.dart';
import 'package:material_ui/material_ui.dart';

class const WelcomeLogo({super.key, required final String title})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: UIHelpers.paddingT4B32,
          child: const BaseText(
            'Welcome',
            color: AppColors.primary,
            textType: .headlineLarge,
            fontWeight: .w900,
          ),
        ),
        UIHelpers.spaceV20,
        Align(
          alignment: .centerLeft,
          child: BaseText.titleMedium(title, color: AppColors.blackE1),
        ),
      ],
    );
  }
}
