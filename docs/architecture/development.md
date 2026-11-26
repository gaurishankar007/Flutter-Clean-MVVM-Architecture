# Development

## SDK and Idioms

The template targets the SDK installed on the development machine (currently **Dart 3.14 / Flutter 3.50**; see `pubspec.yaml`'s `environment`). Use the newest idioms (primary constructors, dot shorthands, null-aware elements, switch expressions, `Future.syncValue`); `CLAUDE.md` § "Modern Dart & Flutter" lists them. When a newer SDK is installed, bump `environment`, migrate, and update `.github/actions/setup-flutter/action.yml` to match `flutter --version`.

## Setup

```bash
cp .env.example .env              # base URLs per flavor (gitignored)
flutter pub get
dart run build_runner build       # routes, DI, drift
flutter run --flavor development -t lib/main_dev.dart
```

`.env` is a bundled asset, so it must exist before building. Without a key, `AppConfig` falls back to the demo backend (`https://dummyjson.com/`).

## Flavors

| Flavor | Entry point | Run |
| --- | --- | --- |
| development | `lib/main_dev.dart` | `flutter run --flavor development -t lib/main_dev.dart` |
| staging | `lib/main_stg.dart` | `flutter run --flavor staging -t lib/main_stg.dart` |
| production | `lib/main.dart` | `flutter run --flavor production -t lib/main.dart` |

Android flavors are product flavors in `android/app/build.gradle.kts` (`.dev` / `.stg` application id suffixes); iOS uses one scheme and build configurations per flavor. Web has no flavors: pass `-t` only (`flutter run -d chrome -t lib/main_dev.dart`).

## Lints and Formatting

- `leancode_lint` plus the rules in `analysis_options.yaml` (package imports, single quotes, declaring parameters, null-aware elements, `Future.syncValue`...). `use_primary_constructors` is off on purpose: it flags every class without a constructor.
- `flutter analyze` must report zero issues; run `dart format lib test testing patrol_test` and `dart fix --apply` before finishing.
- Generated files (`*.g.dart`, `*.gr.dart`, `*.config.dart`) are excluded from analysis and never edited by hand.

## Code Generation

```bash
dart run build_runner build                # one-off
dart run build_runner watch -d             # while iterating
```

Regenerate after changing a route, an injectable class or a drift table. injectable warns that the local services depend on the unregistered `AppDatabase`; that's expected (it's registered by hand).

## Scaffolding

Mason bricks in `bricks/` (`riverpod_feature`, `riverpod_view`, `domain_data_model`) generate files in this layout. See the `scaffolding` skill (`.claude/skills/scaffolding/SKILL.md`).

## App Icon and Splash

Sources live in `assets/icon/`; the `flutter_launcher_icons` and `flutter_native_splash` configs are at the bottom of `pubspec.yaml` (both are dev dependencies). What each image is for: [Design System](../design/design_system.md#app-icon-and-splash).

```bash
dart run flutter_launcher_icons          # Android (adaptive + themed), iOS, Web icons
dart run flutter_native_splash:create    # native splash: Android (incl. 12+), iOS, Web
```

Run the first after changing any icon image, the second after changing the splash images or colours. Both overwrite generated platform files (mipmaps, drawables, `AppIcon.appiconset`, `LaunchImage`, `web/icons/`, `web/splash/`, `web/index.html`), so commit their output.

Before committing, check `git diff ios/` for two known side effects and revert them:

- `flutter_launcher_icons` rewrites `ASSETCATALOG_COMPILER_GENERATE_SWIFT_ASSET_SYMBOL_EXTENSIONS = YES` to `AppIcon` in `ios/Runner.xcodeproj/project.pbxproj` (`git checkout ios/Runner.xcodeproj/project.pbxproj`).
- `flutter_native_splash` re-indents all of `ios/Runner/Info.plist` to add `UIStatusBarHidden = false`, which is already the default (`git checkout ios/Runner/Info.plist`).

## Web

drift runs on web through `web/sqlite3.wasm` and `web/drift_worker.js` (shipped with the app). Keep them in sync with the `sqlite3`/`drift` package versions when you upgrade drift (download them from the matching drift and sqlite3 releases).

## Releases

Builds reach testers through Firebase App Distribution (Android) and TestFlight (iOS), started by hand from GitHub Actions or locally with fastlane. See `.claude/workflows/release.md` and the README's "CI/CD & Release" section.
