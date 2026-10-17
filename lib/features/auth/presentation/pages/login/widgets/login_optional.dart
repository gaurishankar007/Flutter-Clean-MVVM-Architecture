import 'package:clean_architecture/features/auth/presentation/cubits/login/login_cubit.dart';
import 'package:clean_architecture/shared_ui/ui/base/base_checkbox.dart';
import 'package:clean_architecture/shared_ui/ui/base/buttons/base_text_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

class const LoginOptional({super.key, required final bool saveUserCredential})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        BaseCheckbox(
          value: saveUserCredential,
          title: 'Stay Logged In',
          onChanged: (value) =>
              context.read<LoginCubit>().toggleUserCredentialSaving(),
        ),
        BaseTextButton(onPressed: () {}, text: 'Forget Password?'),
      ],
    );
  }
}
