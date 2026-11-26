# Tasks (example)

Files: `lib/ui/features/todos/`, `lib/domain/models/{todo,subtask,todo_priority,todo_category,todo_query,todo_stats}.dart`, `lib/domain/repositories/todo_repository.dart`, `lib/domain/use_cases/{sync_todos,save_todo,set_todo_completed}_use_case.dart`, `lib/data/repositories/todo_repository_impl.dart`, `lib/data/services/{local/todo_local_service,remote/todo_api_service}.dart`.

## The Model

A `Todo` has a title, notes, `TodoPriority` (low/medium/high), `TodoCategory` (personal, work, shopping, health, learning, other), an optional due date (midnight = all day; otherwise a time), `Subtask`s, completion time and timestamps. Derived logic lives on the model: `isOverdue(now)`, `isDueToday(now)`, `progress`.

`TodoQuery` (filter + category + search + sort) and `TodoStats` are pure domain logic with `now:` parameters, so they're unit-tested without mocks.

## Screens

| Screen | Route | Notifier |
| --- | --- | --- |
| Tasks tab | `/home/tasks` | `todosProvider` (keep-alive) |
| Task detail | `/tasks/:todoId` | `todoDetailProvider(id)` (auto-dispose family) |
| New / edit task | `/tasks/editor?id=` | `todoEditorProvider(id?)` (auto-dispose family) |

### Tasks tab

Header (date, greeting, avatar), a stats card (today's progress ring, due today / overdue / completed), a debounced search, filter chips (All, Today, Upcoming, Overdue, Completed), a sort menu (due date, priority, newest), category chips, and the list grouped into Overdue / Today / Upcoming / No due date / Completed. Each `TodoCard` has a priority stripe, a round checkbox, notes preview, category tag, due label (red when overdue) and subtask count. Long-press opens Edit / Delete; pull to refresh syncs. A floating **New task** button sits above the bottom bar.

Filtering, sorting and grouping are computed in the state (`TodosState.sections`), never in widgets.

### Detail

Title, priority/category/due tags, notes, the subtask checklist with a progress bar (toggle in place), and created/updated times. **Mark as done** / **Mark as not done** is pinned at the bottom; Edit and Delete (confirmed) are at the top.

### Editor

Title (required, max 120), notes, priority (`SegmentedPicker`), category chips, due day and time (Material pickers; a time without a day lands on today), and a subtask list. **Save** is pinned. Leaving with unsaved changes asks to discard. A new task opens its detail after saving; an edit returns to where it came from.

## Sync

`TodosNotifier` syncs once when first watched and on pull-to-refresh, through `SyncTodosUseCase`:

1. `TodoRepository.sync()` fetches the demo API's sample list (`GET todos?limit=30`), merges by `remoteId` (new tasks are imported whole; for known tasks only the server's own fields, title and done, are updated) and upserts the changes.
2. If **Due reminders** is on, it adds an inbox reminder for each task due today or overdue, once per task per day (the notification id includes the day).

The demo API only has a title and a done flag, so `TodoResponse.toDomain()` spreads priority, category and due dates by id to make the sample list show every state.

Offline, the list keeps working on the local table; a manual refresh shows "You're offline, showing tasks on this device."

## Use Cases

- `SaveTodoUseCase`: saves; a new task also gets an "Added" inbox entry.
- `SetTodoCompletedUseCase`: sets done/not done and `completedAt`; completing adds a "Completed" entry.
