import 'package:clean_architecture/ui/core/providers/screen_type/screen_type_notifier.dart';
import 'package:clean_architecture/ui/core/themes/app_spacing.dart';
import 'package:clean_architecture/ui/core/themes/theme.dart';
import 'package:clean_architecture/ui/core/ui/base/layout/pinned_action_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

/// A screen's scrolling body: safe area, side padding by breakpoint, content
/// capped at a readable width, and room for the floating nav bar.
///
/// A [bottomAction] (the screen's primary button) is pinned at the bottom,
/// above the nav bar, whatever the content's height; the content scrolls
/// above it.
class const ScreenScrollView({
  super.key,
  required final List<Widget> children,
  final Widget? background,
  final Widget? bottomAction,

  /// Enables pull-to-refresh.
  final Future<void> Function()? onRefresh,
}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenType = ref.watch(screenTypeProvider);
    final sidePadding = screenType == .phone
        ? AppSpacing.screenPhone
        : AppSpacing.screenWide;
    // The shell's Scaffold (extendBody) reports the floating nav bar's height
    // as bottom padding; pushed screens report the home indicator.
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    final Widget scrollView = SingleChildScrollView(
      keyboardDismissBehavior: .onDrag,
      physics: onRefresh == null ? null : const AlwaysScrollableScrollPhysics(),
      padding: .fromLTRB(
        sidePadding,
        0,
        sidePadding,
        bottomAction == null ? bottomInset + AppSpacing.xl : AppSpacing.xl,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppSpacing.maxContentWidth,
          ),
          child: Column(crossAxisAlignment: .stretch, children: children),
        ),
      ),
    );

    final body = onRefresh == null
        ? scrollView
        : RefreshIndicator(
            onRefresh: onRefresh!,
            color: context.colors.primaryText,
            backgroundColor: context.colors.surface,
            child: scrollView,
          );

    return Stack(
      children: [
        ?background,
        SafeArea(
          bottom: false,
          child: bottomAction == null
              ? body
              : Column(
                  children: [
                    Expanded(child: body),
                    PinnedActionBar(
                      color: context.colors.background,
                      sidePadding: sidePadding,
                      bottomInset: bottomInset,
                      child: bottomAction!,
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}
