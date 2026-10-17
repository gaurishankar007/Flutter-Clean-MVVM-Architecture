import 'package:clean_architecture/core/constants/app_colors.dart';
import 'package:clean_architecture/shared_ui/ui/base/text/base_text.dart';
import 'package:material_ui/material_ui.dart';

class const BaseTitle({
  super.key,
  required final String title,
  final Color? color,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseText.title(title, color: color ?? AppColors.blackE1);
  }
}
