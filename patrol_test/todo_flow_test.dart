import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:material_ui/material_ui.dart';
import 'package:patrol/patrol.dart';

import 'helpers/test_app.dart' as app;

/// Onboarding → demo login → create a task → complete it → log out.
/// Needs the demo backend (https://dummyjson.com) to be reachable and a fresh
/// install (onboarding not seen).
void main() {
  patrolTest('creates, completes and finds a task', ($) async {
    const title = 'Patrol task';

    await app.main();
    await $(OnboardingMessages.page1Title).waitUntilVisible();
    await $(CommonMessages.skip).tap();

    await $(AuthMessages.useDemo).tap();
    await $(AuthMessages.login).tap();
    await $(TodoMessages.progressTitle).waitUntilVisible();

    await $(TodoMessages.newTask).tap();
    await $(TextField).at(0).enterText(title);
    await $(CommonMessages.save).tap();
    await $(TodoMessages.markDone).waitUntilVisible();
    await $(TodoMessages.markDone).tap();
    await $(TodoMessages.markNotDone).waitUntilVisible();

    await $(CommonMessages.back).tap();
    await $(TodoMessages.filterCompleted).tap();
    await $(title).waitUntilVisible();

    await $(NavMessages.profile).tap();
    await $(ProfileMessages.logout).scrollTo().tap();
    await $(ProfileMessages.logout).at(1).tap();
    await $(AuthMessages.loginTitle).waitUntilVisible();
  });
}
