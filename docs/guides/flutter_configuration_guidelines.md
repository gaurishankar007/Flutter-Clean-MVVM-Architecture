# Flutter Configuration Guidelines

A collection of essential and frequently needed guidelines to set up Flutter properly and boost your productivity.

## 1. Activate Flutter Pub Executable Commands

- `Windows`: Add this path `"C:\Users\{username}\AppData\Local\Pub\Cache\bin"` to system's Path.
- `macOs`: Add this path `export PATH="$PATH":"$HOME/.pub-cache/bin"` inside the `.zshrc` file.

## 2. Firebase CLI

- ✅ Activate flutter pub executable commands and install Node.js.
- ✅ Install the Firebase CLI:
  - Windows: `npm install -g firebase-tools`.
  - macOs: `sudo npm install -g firebase-tools`.
- ✅ Log in to Firebase: `firebase login`.
- ✅ Activate the FlutterFire CLI in a Flutter project: `dart pub global activate flutterfire_cli`.
- ✅ Configure Firebase for your Flutter project: `flutterfire configure`.

---

## 3. Change Java SDK Location Used by Flutter

By default Flutter uses the JDK bundled with Android Studio (its `jbr` folder, e.g. `C:\Program Files\Android\Android Studio\jbr` on Windows) and ignores `JAVA_HOME`. To build with a different JDK, point Flutter at it.

This project needs **Java 21** (the Android Gradle Plugin 9 release lint requires it; CI uses the same version).

- ✅ `flutter config --jdk-dir="<java-directory>"`: Change the Java SDK directory used by Flutter.
- ✅ `flutter doctor --verbose`: Confirm which Java version Flutter now uses.

---
