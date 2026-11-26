# Settings (example)

Files: `lib/ui/features/settings/`, `lib/ui/core/providers/settings/`, `lib/domain/models/app_settings.dart`, `lib/data/repositories/settings_repository_impl.dart`.

## Preferences (`appSettingsProvider`, core)

`AppSettings` (theme mode, due reminders, onboarding seen) is stored as JSON in `key_value` and loaded at startup, so the first frame already has the right theme. `AppSettingsNotifier` changes are optimistic: the UI updates at once and rolls back with an error toast if saving fails.

## Settings tab (`/home/settings`)

- **Appearance:** System / Light / Dark.
- **Tasks:** Due reminders switch; **Clear completed tasks** (confirmed; toast with the count).
- **About:** app version (`AppInfoRepository`, from `package_info_plus`) and **Error log**.

## Error log (`/settings/error-log`)

Lists the `error_log` table, newest first: time, message, action path, raw error and a "Shown" tag for errors the user saw. **Copy** puts the whole log on the clipboard for a bug report; **Clear log** empties it. See [Error Handling](../core/error_handling.md#recorders).
