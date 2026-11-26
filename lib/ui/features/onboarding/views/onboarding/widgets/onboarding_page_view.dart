import 'package:clean_architecture/ui/features/onboarding/models/onboarding_page.dart';
import 'package:clean_architecture/ui/features/onboarding/views/onboarding/widgets/onboarding_slide.dart';
import 'package:material_ui/material_ui.dart';

/// The swipeable onboarding pages.
class const OnboardingPageView({
  super.key,
  required final PageController controller,
  required final ValueChanged<int> onPageChanged,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller,
      onPageChanged: onPageChanged,
      children: [
        for (final page in OnboardingPage.values) OnboardingSlide(page: page),
      ],
    );
  }
}
