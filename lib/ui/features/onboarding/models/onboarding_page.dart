import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';

/// The onboarding pages, in order.
enum OnboardingPage {
  capture(
    Symbols.edit_note_rounded,
    OnboardingMessages.page1Title,
    OnboardingMessages.page1Body,
  ),
  schedule(
    Symbols.event_upcoming_rounded,
    OnboardingMessages.page2Title,
    OnboardingMessages.page2Body,
  ),
  offline(
    Symbols.cloud_sync_rounded,
    OnboardingMessages.page3Title,
    OnboardingMessages.page3Body,
  );

  new(this.icon, this.title, this.body);

  final IconData icon;
  final String title;
  final String body;
}
