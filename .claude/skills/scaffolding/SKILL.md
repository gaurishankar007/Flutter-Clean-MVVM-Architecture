---
name: scaffolding
description: Automates code scaffolding (Mason) for features, screens and models in this project
---

# Scaffolding Skill

Use [Mason](https://pub.dev/packages/mason_cli) to generate boilerplate that
follows this project's Clean Architecture + MVVM layout (see
`docs/architecture/architecture.md`). Bricks live in `bricks/` and are
registered in `mason.yaml`.

## 0. Setup (once per machine)

```bash
dart pub global activate mason_cli
mason get
```

If `mason make` says a brick can't be found, delete `.mason/` and
`mason-lock.json` (both gitignored) and run `mason get` again.

## 1. Edit `config.json`

Every brick reads its variables from `config.json` in the repo root (values on
the command line don't override it, so edit the file):

```json
{
  "feature": "habit",
  "notifier": "habits",
  "view": "habits",
  "model": {
    "name": "habit",
    "variables": [
      { "name": "id", "type": "int" },
      { "name": "title", "type": "String" }
    ]
  },
  "response": { "name": "habit", "variables": [ ... ] },
  "request": { "name": "createHabit", "variables": [ ... ] }
}
```

- `feature` → folder `lib/ui/features/<feature>/` and the `<Feature>Repository` / services.
- `notifier` → `<Notifier>Notifier` + `<Notifier>State` and `<notifier>Provider`.
- `view` → `<View>Screen` (`@RoutePage()`) and its `<View>Body` widget.

## 2. Pick a brick

| Brick | Generates | When |
| --- | --- | --- |
| `riverpod_feature` | domain model, response + request DTOs, repository contract + impl, local + API services, Notifier + state, screen + body | A new feature with its own data |
| `riverpod_view` | Notifier + state, screen + body | A new screen in a feature whose repository exists |
| `domain_data_model` | domain model, response + request DTOs | A new model for an existing repository |

```bash
mason make riverpod_feature -c config.json
mason make riverpod_view -c config.json
mason make domain_data_model -c config.json
```

## 3. Finish the wiring

1. Add the screen to `lib/routing/routes.dart` (guard it with `_auth` when it
   needs a session).
2. Move the screen title and any text into `lib/core/messages/app_messages.dart`
   and bump `kMessagesVersion`.
3. Add a drift table under `lib/core/clients/database/tables/` and list it in
   `AppDatabase` if the feature stores data locally.
4. Run the `codegen` skill, then `dart format lib`.
5. Add mocks for the new repository/services to `testing/mocks/`.

## 4. Verify

```bash
flutter analyze   # zero issues
flutter test
```

The skeletons carry documented `// ignore:` comments for fields that stay
unused until you add the first method; remove them once the code uses them.
