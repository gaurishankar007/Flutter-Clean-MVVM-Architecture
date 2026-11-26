# Local Database

Files: `lib/core/clients/database/`. Uses [drift](https://drift.simonbinder.eu/) on SQLite (native) and `sqlite3.wasm` + a worker (web).

## Tables

| Table (`tableName`) | Class | Holds | Kind |
| --- | --- | --- | --- |
| `key_value` | `KeyValueLocal` | JSON values by key: session, settings | Foundation |
| `error_log` | `ErrorLogLocal` | The last 500 errors (`AppErrorRecorder`) | Foundation |
| `todos` | `TodoLocal` | Tasks; subtasks as a JSON column; `remoteId` unique for sync | Example |
| `notifications` | `NotificationLocal` | Inbox entries | Example |

`AppDatabase` is registered by hand in `configureDependencies` (before injectable runs) because the error recorder needs it. Services read and write it; repositories map rows to domain models with the extensions in `lib/data/models/mappers/`.

## Reading and Watching

Services wrap one-off queries in `ErrorHandler.execute` and `watch()` streams in `ErrorHandler.executeStream`, so a database error becomes a `FailureState` event instead of a crash. Screens watch streams, so every change shows up everywhere at once.

## Migrations

Schema 1 hasn't shipped, so tables can still change in place. From the first release on:

1. Bump `schemaVersion` and add an explicit `onUpgrade` step for that `from → to` transition. Never rely on dropping and recreating tables: that wipes users' data.
2. Export a schema snapshot with `dart run drift_dev make-migrations` and commit it. Never delete exported snapshots: each one verifies upgrades from that version.
3. Add a migration test with drift's `SchemaVerifier` that runs the real upgrade path.

## Web

`DriftWebOptions` points to `web/sqlite3.wasm` and `web/drift_worker.js`. Update both when you upgrade `drift`/`sqlite3`.
