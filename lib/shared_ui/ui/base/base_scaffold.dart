import 'package:clean_architecture/core/constants/app_colors.dart';
import 'package:clean_architecture/shared_ui/utils/extensions/build_context_extension.dart';
import 'package:clean_architecture/shared_ui/utils/screen_util/screen_util.dart';
import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';

class const BaseScaffold({
  super.key,
  final bool showAnnotatedRegion = false,
  final void Function()? onPopInvokedWithResult,
  final bool? resizeToAvoidBottomInset,
  final Widget? appBar,
  final Future<void> Function()? onRefresh,
  final bool isScrollable = true,
  final ScrollPhysics? scrollPhysics,
  final EdgeInsets? padding,
  final bool usePadding = true,
  required final Widget body,
  final Widget? bottomNavigationBar,
  final bool useBottomNavigationPadding = true,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget newChild = body;

    if (isScrollable) {
      newChild = SingleChildScrollView(
        physics: scrollPhysics,
        padding: padding ?? ScreenUtil.I.pagePadding(),
        child: body,
      );
    } else if (usePadding) {
      newChild = Padding(
        padding: padding ?? ScreenUtil.I.pagePadding(),
        child: body,
      );
    }

    if (onRefresh != null) {
      newChild = RefreshIndicator(
        onRefresh: onRefresh!,
        color: AppColors.primary,
        backgroundColor: AppColors.white,
        strokeWidth: 2,
        edgeOffset: 100,
        child: newChild,
      );
    }

    PreferredSize? appBarWidget;
    if (appBar != null) {
      appBarWidget = PreferredSize(
        preferredSize: const Size(double.maxFinite, 50),
        child: appBar!,
      );
    }

    Widget? bottomNavigationWidget = bottomNavigationBar;
    if (bottomNavigationBar != null && useBottomNavigationPadding) {
      bottomNavigationWidget = Padding(
        padding: (padding ?? ScreenUtil.I.pagePadding()).copyWith(top: 0),
        child: bottomNavigationWidget,
      );
    }

    Widget scaffold = Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: appBarWidget,
      body: SafeArea(child: newChild),
      bottomNavigationBar: bottomNavigationWidget,
    );

    if (onPopInvokedWithResult != null) {
      scaffold = PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) {
            return;
          }
          onPopInvokedWithResult?.call();
        },
        child: scaffold,
      );
    }

    if (showAnnotatedRegion) {
      return AnnotatedRegion<SystemUiOverlayStyle>(
        value: context.systemOverlayStyle,
        child: scaffold,
      );
    }

    return scaffold;
  }
}
