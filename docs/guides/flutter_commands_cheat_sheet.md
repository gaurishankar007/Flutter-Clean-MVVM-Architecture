# Flutter Commands Cheat Sheet 📋

A collection of essential and frequently used Flutter commands to boost your productivity.

---

## 1. Environment Setup

- ✅ `flutter doctor`: Check Flutter installation and environment setup.
- ✅ `flutter doctor --verbose`: View more details like the Java version used by Flutter.

---

## 2. Project Management

### Create Projects

- ✅ `flutter create my_app`: Create a Flutter project with the name `my_app` and all supported platforms.
- ✅ `flutter create --org com.example my_app`: Create a Flutter project with a specified organization name.
- ✅ `flutter create --platforms=android,ios,web .`: Add platforms to an existing Flutter project.
- ✅ `flutter create --platforms=android,ios,web my_app`: Create a Flutter project with specified platforms.
- ✅ `dart create --template package my_package`: Create a Dart package.
- ✅ `flutter create --template=plugin --platforms=android,ios,web -a kotlin -i swift my_plugin_name`: Create a Flutter plugin with specified platforms.

---

## 3. Dependency Management

### Fetch and Update Dependencies

- ✅ `dart pub get`: Fetch project dependencies.
- ✅ `flutter pub get`: Get project dependencies.
- ✅ `flutter pub upgrade`: Upgrade all dependencies to the newest versions `pubspec.yaml` allows (changes only `pubspec.lock`).
- ✅ `flutter pub upgrade --dry-run`: Preview what would change without changing anything.
- ✅ `flutter pub upgrade --tighten`: Upgrade and raise `pubspec.yaml` lower bounds to the resolved versions.
- ✅ `flutter pub upgrade --major-versions`: Upgrade to the latest resolvable versions, including breaking majors, and update `pubspec.yaml`.
- ✅ `flutter pub upgrade --offline`: Upgrade using only cached packages.

### Upgrade Specific Packages

- ✅ `flutter pub upgrade foo bar`: Upgrade only the named packages.
- ✅ `flutter pub upgrade foo --unlock-transitive`: Also upgrade the named package's transitive dependencies.
- ✅ `flutter pub upgrade foo@^1.2.3`: Upgrade within a constraint (same syntax as `pubspec.yaml`).
- ✅ `flutter pub upgrade foo@1.2.3`: Upgrade to an exact version.
- ✅ `flutter pub upgrade 'foo@>=1.2.0 <2.0.0'`: Upgrade within a range (quote it when using `<`, `>` or spaces).
- ✅ `flutter pub upgrade foo@latest`: Upgrade to the latest published version, even if breaking.
- ✅ `flutter pub upgrade foo@resolvable`: Upgrade to the newest version that resolves with the other dependencies.

> Packages that `flutter pub outdated` lists as behind but not "Resolvable" are held back by other packages that depend on them (or by the Flutter SDK), not by your `pubspec.yaml`, so `--major-versions` won't move them. See https://dart.dev/tools/pub/cmd/pub-upgrade.

### Add or Remove Dependencies

- ✅ `flutter pub add <package_name>`: Add a new dependency.
- ✅ `flutter pub remove <package_name>`: Remove a dependency.

### Analyze Dependencies

- ✅ `flutter pub deps`: List all dependencies and their versions.
- ✅ `flutter pub outdated`: Check for outdated dependencies.
- ✅ `dart pub cache clean`: Clear the Dart pub dependency cache.

---

## 4. Code Quality and Testing

### Analyze Code

- ✅ `flutter analyze`: Analyze the project for potential issues.

### Run Tests

- ✅ `flutter test`: Run unit and widget tests.
- ✅ `flutter test --tags regression`: Run only the issue regression tests.
- ✅ `flutter test --exclude-tags regression`: Run everything except the regression tests.
- ✅ `flutter test --coverage`: Generate test coverage reports.
- ✅ `patrol test --target patrol_test/todo_flow_test.dart`: Run a Patrol integration test on a device or simulator.

---

## 5. Code Generation (Build Runner)

- ✅ `dart run build_runner build`: Build generated files (routes, DI, drift).
- ✅ `dart run build_runner watch`: Watch for changes and rebuild files.

---

## 6. Running the App

### Debug Mode

- ✅ `flutter run`: Run in debug mode.
- ✅ `flutter run --debug -d android/ios/chrome`: Run on a specific platform.

### Profile Mode

- ✅ `flutter run --profile`: Run in profile mode.

### Release Mode

- ✅ `flutter run --release`: Run in release mode.

### Flavors

- ✅ `flutter run --flavor development -t lib/main_dev.dart`: Run the "development" flavor.
- ✅ `flutter run --flavor staging -t lib/main_stg.dart`: Run the "staging" flavor.
- ✅ `flutter run --flavor production -t lib/main.dart`: Run the "production" flavor.
- ✅ `flutter run -d chrome -t lib/main_dev.dart`: Run on Web. Web has no flavors, so pass `-t` only.

### Web Options

- ✅ `flutter run -d chrome --web-browser-flag "--disable-web-security"`: Run on Chrome with web security disabled.

---

## 7. Building the App

### Build for Platforms

- ✅ `flutter build apk --release --flavor staging -t lib/main_stg.dart`: Build a release APK of the "staging" flavor.
- ✅ `flutter build appbundle --release --flavor production -t lib/main.dart`: Build a "production" app bundle for Play Store uploads.
- ✅ `flutter build ipa --release --flavor production -t lib/main.dart`: Build a "production" iOS archive.
- ✅ `flutter build web -t lib/main.dart`: Build the web app.

### Analyze Build Size

- ✅ `flutter build apk --flavor production -t lib/main.dart --analyze-size`: Analyze APK size.
- ✅ `flutter build appbundle --flavor production -t lib/main.dart --analyze-size`: Analyze app bundle size.
- ✅ `flutter build ios --flavor production -t lib/main.dart --analyze-size`: Analyze iOS app size.

---

## 8. Distribution (fastlane)

Credentials live in `fastlane/.env` and `fastlane/keys/` (both gitignored). See `.claude/workflows/release.md` before releasing.

- ✅ `bundle install`: Install fastlane and its plugins.
- ✅ `bundle exec fastlane android staging`: Build "staging" and upload it to Firebase App Distribution.
- ✅ `bundle exec fastlane ios staging`: Build "staging" and upload it to TestFlight.
- ✅ `bundle exec fastlane <android|ios> production`: The same for "production".

---

## 9. Mason CLI

- ✅ `mason get`: Fetch the bricks listed in `mason.yaml`.
- ✅ `mason make riverpod_feature -c config.json`: Scaffold a feature (data + domain + UI).
- ✅ `mason make riverpod_view -c config.json`: Scaffold a screen + Notifier in an existing feature.
- ✅ `mason make domain_data_model -c config.json`: Scaffold a domain model + DTOs.

---

## 10. Android Release Essentials

- ✅ `keytool -genkey -v -keystore upload-keystore.jks`: Generate a keystore file.
