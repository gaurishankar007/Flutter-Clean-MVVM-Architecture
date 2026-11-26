# App Messages

File: `lib/core/messages/app_messages.dart`. Current `kMessagesVersion`: `1`.

Every string the app writes itself (toasts, labels, dialog text, empty and error states, validator errors, semantic labels, failure messages) lives in one catalog. Never write a user-facing literal at the call site; tests use the same constants as finders.

## Layout

One class per area, a `///` comment saying when each string is shown:

```dart
abstract final class TodoMessages {
  /// TodosScreen empty states.
  static const emptyTitle = 'No tasks yet';
  static const emptyBody = 'Tap New task to plan your first one.';

  /// Pull-to-refresh result toasts.
  static String synced(int count) =>
      count == 0 ? 'Everything is up to date.' : 'Synced $count tasks.';
}
```

| Class | Holds |
| --- | --- |
| `CommonMessages` | Generic, network and storage failures; shared buttons; the offline banner |
| `ValidationMessages` | Validator errors |
| `StartupMessages` | Startup error screen, splash tagline |
| `OnboardingMessages` | Onboarding pages |
| `AuthMessages` | Login screen, demo account, logged in/out, session expired |
| `NavMessages` | Tab labels |
| `TodoMessages` | Task list, filters, detail, editor, priorities, categories |
| `NotificationMessages` | Inbox screen and the generated notification texts |
| `ProfileMessages` | Profile and edit profile |
| `SettingsMessages` | Settings screen |
| `ErrorLogMessages` | Error log screen |

## Writing Style

- Short, plain, second person: "Tap New task to plan your first one."
- Say what to do next when something fails ("Check your connection and try again.").
- No technical words (HTTP codes, exception names) in user text; the error log keeps the detail.

## Versioning

`kMessagesVersion` sits under a library doc comment that is the changelog. When a message is added, removed or reworded, bump it and add one line there.

## Localisation

English only. Keeping every string in one place makes a later move to ARB files (`flutter_localizations` + `intl`) mechanical.
