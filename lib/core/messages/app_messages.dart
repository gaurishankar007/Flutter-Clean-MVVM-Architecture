/// Every user-facing string the app writes itself.
///
/// Bump [kMessagesVersion] and add a changelog line here when a message is
/// added, removed or reworded. See docs/core/app_messages.md.
library;

/// 1: first catalog (template release).
const kMessagesVersion = 1;

abstract final class CommonMessages {
  /// Fallback for any failure without a clearer message.
  static const genericError = 'Something went wrong. Please try again.';

  /// Network and server failures (DioErrorTranslator, FailureState).
  static const noInternet =
      "You're offline. Check your connection and try again.";
  static const network = "Couldn't reach the server. Check your connection.";
  static const badRequest =
      "The server didn't accept that. Check and try again.";
  static const badResponse = 'The server sent something unexpected.';
  static const serverError =
      'The server had a problem. Please try again later.';
  static const unauthorized = 'Your session has expired. Please log in again.';
  static const tokenExpired = unauthorized;
  static const notFound = "That couldn't be found.";

  /// Local storage failures (DriftErrorTranslator).
  static const storageError = "Couldn't read or save data on this device.";

  /// Buttons and semantic labels shared by dialogs, sheets and cards.
  static const retry = 'Retry';
  static const ok = 'OK';
  static const cancel = 'Cancel';
  static const close = 'Close';
  static const back = 'Back';
  static const save = 'Save';
  static const edit = 'Edit';
  static const delete = 'Delete';
  static const done = 'Done';
  static const next = 'Next';
  static const skip = 'Skip';
  static const moreActions = 'More actions';
  static const copy = 'Copy';
  static const copied = 'Copied to the clipboard.';

  /// OfflineBanner in the home shell.
  static const offline = "You're offline. Changes are saved on this device.";

  /// ErrorState default title.
  static const errorTitle = "That didn't work";
}

abstract final class ValidationMessages {
  /// Validators: a required field is empty.
  static const required = 'This field is required.';
  static const invalidEmail = 'Enter a valid email address.';
  static const invalidPhone = 'Enter a valid phone number.';
  static const passwordTooShort = 'Use at least 6 characters.';

  /// TodoEditor: the title is longer than allowed.
  static const titleTooLong = 'Keep the title under 120 characters.';
}

abstract final class StartupMessages {
  /// StartupErrorApp: initialisation failed.
  static const startupFailedTitle = "The app couldn't start";
  static const startupFailedBody =
      'Something went wrong while getting things ready. Try again.';

  /// SplashScreen tagline under the app name.
  static const tagline = 'Plan it. Do it. Done.';
}

abstract final class OnboardingMessages {
  /// Onboarding pages: title + body.
  static const page1Title = 'Capture everything';
  static const page1Body =
      'Add tasks with notes, priorities, categories, due dates and subtasks.';
  static const page2Title = 'Stay on schedule';
  static const page2Body =
      'Today, upcoming and overdue views keep the next thing in front of you.';
  static const page3Title = 'Works offline';
  static const page3Body =
      'Your tasks live on your device and sync when you are back online.';

  /// Last page's button.
  static const getStarted = 'Get started';
}

abstract final class AuthMessages {
  /// LoginScreen header.
  static const loginTitle = 'Welcome back';
  static const loginSubtitle = 'Log in to see your tasks.';

  /// LoginForm fields and button.
  static const username = 'Username';
  static const password = 'Password';
  static const showPassword = 'Show password';
  static const hidePassword = 'Hide password';
  static const login = 'Log in';

  /// LoginScreen: the demo backend's public test account.
  static const demoHint = 'Demo account: emilys / emilyspass';
  static const useDemo = 'Use demo account';

  /// Toast after a successful login.
  static const loggedIn = 'Logged in.';

  /// Toast after logout and when the session expired.
  static const loggedOut = 'Logged out.';
  static const sessionExpired = CommonMessages.unauthorized;
}

abstract final class NavMessages {
  /// Tab labels.
  static const tasks = 'Tasks';
  static const notifications = 'Inbox';
  static const profile = 'Profile';
  static const settings = 'Settings';
}

abstract final class TodoMessages {
  /// TodosScreen header; greeting depends on the time of day.
  static const goodMorning = 'Good morning';
  static const goodAfternoon = 'Good afternoon';
  static const goodEvening = 'Good evening';
  static String greeting(String greeting, String name) =>
      name.isEmpty ? greeting : '$greeting, $name';

  /// TodoStatsCard.
  static const progressTitle = "Today's progress";
  static String progressBody(int done, int total) =>
      total == 0 ? 'Nothing planned yet.' : '$done of $total tasks done';
  static const statToday = 'Due today';
  static const statOverdue = 'Overdue';
  static const statCompleted = 'Completed';

  /// TodosScreen search field and filters.
  static const searchHint = 'Search tasks';
  static const clearSearch = 'Clear search';
  static const filterAll = 'All';
  static const filterToday = 'Today';
  static const filterUpcoming = 'Upcoming';
  static const filterOverdue = 'Overdue';
  static const filterCompleted = 'Completed';
  static const sortBy = 'Sort by';
  static const sortDueDate = 'Due date';
  static const sortPriority = 'Priority';
  static const sortCreated = 'Newest';
  static const allCategories = 'All categories';

  /// Section headers in the grouped list.
  static const sectionOverdue = 'Overdue';
  static const sectionToday = 'Today';
  static const sectionUpcoming = 'Upcoming';
  static const sectionNoDate = 'No due date';
  static const sectionCompleted = 'Completed';

  /// TodosScreen empty states.
  static const emptyTitle = 'No tasks yet';
  static const emptyBody = 'Tap New task to plan your first one.';
  static const noMatchesTitle = 'Nothing matches';
  static const noMatchesBody = 'Try another filter or search.';

  /// FAB and editor titles.
  static const newTask = 'New task';
  static const editTask = 'Edit task';

  /// Pull-to-refresh result toasts.
  static String synced(int count) =>
      count == 0 ? 'Everything is up to date.' : 'Synced $count tasks.';
  static const offlineSync = "You're offline, showing tasks on this device.";

  /// TodoCard / detail labels.
  static const markDone = 'Mark as done';
  static const markNotDone = 'Mark as not done';
  static const completed = 'Task completed.';
  static const reopened = 'Task reopened.';
  static String subtaskProgress(int done, int total) => '$done/$total';
  static const dueToday = 'Today';
  static const dueTomorrow = 'Tomorrow';
  static const dueYesterday = 'Yesterday';
  static const noDueDate = 'No due date';

  /// TodoDetailScreen.
  static const notes = 'Notes';
  static const noNotes = 'No notes.';
  static const subtasks = 'Subtasks';
  static const noSubtasks = 'No subtasks yet.';
  static const details = 'Details';
  static const priority = 'Priority';
  static const category = 'Category';
  static const dueDate = 'Due';
  static const created = 'Created';
  static const updated = 'Updated';
  static const notFound = 'This task no longer exists.';

  /// Delete confirmation.
  static const deleteTitle = 'Delete this task?';
  static const deleteBody =
      "It will be removed from this device. This can't be undone.";
  static const deleted = 'Task deleted.';

  /// TodoEditorScreen.
  static const titleLabel = 'Title';
  static const titleHint = 'What needs doing?';
  static const notesLabel = 'Notes';
  static const notesHint = 'Add details, links or context';
  static const addSubtask = 'Add a subtask';
  static const removeSubtask = 'Remove subtask';
  static const pickDate = 'Pick a date';
  static const pickTime = 'Add time';
  static const clearDate = 'Clear date';
  static const created_ = 'Task created.';
  static const saved = 'Task saved.';
  static const discardTitle = 'Discard changes?';
  static const discardBody = 'Your edits to this task will be lost.';
  static const discard = 'Discard';

  /// Priority and category labels.
  static const priorityLow = 'Low';
  static const priorityMedium = 'Medium';
  static const priorityHigh = 'High';
  static const categoryPersonal = 'Personal';
  static const categoryWork = 'Work';
  static const categoryShopping = 'Shopping';
  static const categoryHealth = 'Health';
  static const categoryLearning = 'Learning';
  static const categoryOther = 'Other';
}

abstract final class NotificationMessages {
  /// NotificationsScreen header and actions.
  static const title = 'Inbox';
  static const subtitle = 'Reminders and updates about your tasks.';
  static const markAllRead = 'Mark all read';
  static const clearAll = 'Clear all';
  static const clearAllTitle = 'Clear the inbox?';
  static const clearAllBody = 'All notifications will be removed.';
  static const sectionNew = 'New';
  static const sectionEarlier = 'Earlier';
  static const emptyTitle = "You're all caught up";
  static const emptyBody = 'Reminders for due and overdue tasks show up here.';

  /// Generated notification texts (NotificationRepository).
  static const welcomeTitle = 'Welcome aboard';
  static const welcomeBody = 'Your tasks are synced. Plan something for today.';
  static String createdTitle(String task) => 'Added "$task"';
  static const createdBody = 'Open it to add subtasks or a due date.';
  static String completedTitle(String task) => 'Completed "$task"';
  static const completedBody = 'Nice work. Keep the streak going.';
  static String dueTodayTitle(String task) => '"$task" is due today';
  static const dueTodayBody = 'Tap to see the details.';
  static String overdueTitle(String task) => '"$task" is overdue';
  static const overdueBody = 'Reschedule it or mark it done.';
}

abstract final class ProfileMessages {
  /// ProfileScreen.
  static const title = 'Profile';
  static const editProfile = 'Edit profile';
  static const email = 'Email';
  static const phone = 'Phone';
  static const username = 'Username';
  static const statsTitle = 'Your tasks';
  static const statTotal = 'Total';
  static const statDone = 'Done';
  static const statOpen = 'Open';
  static const logout = 'Log out';
  static const logoutTitle = 'Log out?';
  static const logoutBody =
      'Your tasks and inbox on this device will be removed.';
  static const notSet = 'Not set';

  /// EditProfileScreen.
  static const firstName = 'First name';
  static const lastName = 'Last name';
  static const changePhoto = 'Change photo';
  static const removePhoto = 'Remove photo';
  static const saved = 'Profile updated.';
}

abstract final class SettingsMessages {
  /// SettingsScreen sections and tiles.
  static const title = 'Settings';
  static const appearance = 'Appearance';
  static const theme = 'Theme';
  static const themeSystem = 'System';
  static const themeLight = 'Light';
  static const themeDark = 'Dark';
  static const tasks = 'Tasks';
  static const dueReminders = 'Due reminders';
  static const dueRemindersBody =
      'Add inbox reminders for due and overdue tasks.';
  static const clearCompleted = 'Clear completed tasks';
  static const clearCompletedBody =
      'Remove every completed task from this device.';
  static const clearCompletedTitle = 'Clear completed tasks?';
  static String clearedCompleted(int count) =>
      count == 0 ? 'No completed tasks to clear.' : 'Cleared $count tasks.';
  static const about = 'About';
  static const version = 'Version';
  static const errorLog = 'Error log';
  static const errorLogBody = 'Recent errors, to copy into a bug report.';
}

abstract final class ErrorLogMessages {
  /// ErrorLogScreen.
  static const title = 'Error log';
  static const subtitle =
      'The last 500 errors, newest first. Stays on this device.';
  static const emptyTitle = 'No errors';
  static const emptyBody = 'Nothing has gone wrong so far.';
  static const clear = 'Clear log';
  static const shown = 'Shown';
}
