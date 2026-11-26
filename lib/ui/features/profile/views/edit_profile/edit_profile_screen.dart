import 'package:auto_route/auto_route.dart';
import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/ui/core/ui/base/layout/screen_back_button.dart';
import 'package:clean_architecture/ui/core/ui/base/layout/screen_header.dart';
import 'package:clean_architecture/ui/core/ui/base/layout/screen_scroll_view.dart';
import 'package:clean_architecture/ui/core/utils/extensions/ref_extension.dart';
import 'package:clean_architecture/ui/features/profile/providers/edit_profile/edit_profile_notifier.dart';
import 'package:clean_architecture/ui/features/profile/views/edit_profile/widgets/avatar_editor.dart';
import 'package:clean_architecture/ui/features/profile/views/edit_profile/widgets/edit_profile_form.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

@RoutePage()
class const EditProfileScreen({super.key}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listenMessages(editProfileProvider, context);
    return const Scaffold(
      body: ScreenScrollView(
        children: [
          ScreenBackButton(),
          ScreenHeader(title: ProfileMessages.editProfile),
          AvatarEditor(),
          EditProfileForm(),
        ],
      ),
    );
  }
}
