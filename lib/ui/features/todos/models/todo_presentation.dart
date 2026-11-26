import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/domain/models/todo_category.dart';
import 'package:clean_architecture/domain/models/todo_priority.dart';
import 'package:clean_architecture/domain/models/todo_query.dart';
import 'package:clean_architecture/ui/core/themes/app_colors.dart';
import 'package:clean_architecture/ui/features/todos/models/todo_section.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';

/// Labels, icons and colours for the task enums.
extension TodoPriorityPresentation on TodoPriority {
  String get label => switch (this) {
    .low => TodoMessages.priorityLow,
    .medium => TodoMessages.priorityMedium,
    .high => TodoMessages.priorityHigh,
  };

  IconData get icon => switch (this) {
    .low => Symbols.keyboard_double_arrow_down_rounded,
    .medium => Symbols.drag_handle_rounded,
    .high => Symbols.keyboard_double_arrow_up_rounded,
  };

  Color color(AppColors colors) => switch (this) {
    .low => colors.secondary,
    .medium => colors.warning,
    .high => colors.error,
  };
}

extension TodoCategoryPresentation on TodoCategory {
  String get label => switch (this) {
    .personal => TodoMessages.categoryPersonal,
    .work => TodoMessages.categoryWork,
    .shopping => TodoMessages.categoryShopping,
    .health => TodoMessages.categoryHealth,
    .learning => TodoMessages.categoryLearning,
    .other => TodoMessages.categoryOther,
  };

  IconData get icon => switch (this) {
    .personal => Symbols.person_rounded,
    .work => Symbols.work_rounded,
    .shopping => Symbols.shopping_cart_rounded,
    .health => Symbols.favorite_rounded,
    .learning => Symbols.school_rounded,
    .other => Symbols.label_rounded,
  };

  Color get color => AccentColors.values[index % AccentColors.values.length];
}

extension TodoFilterPresentation on TodoFilter {
  String get label => switch (this) {
    .all => TodoMessages.filterAll,
    .today => TodoMessages.filterToday,
    .upcoming => TodoMessages.filterUpcoming,
    .overdue => TodoMessages.filterOverdue,
    .completed => TodoMessages.filterCompleted,
  };
}

extension TodoSortPresentation on TodoSort {
  String get label => switch (this) {
    .dueDate => TodoMessages.sortDueDate,
    .priority => TodoMessages.sortPriority,
    .newest => TodoMessages.sortCreated,
  };

  IconData get icon => switch (this) {
    .dueDate => Symbols.event_rounded,
    .priority => Symbols.flag_rounded,
    .newest => Symbols.schedule_rounded,
  };
}

extension TodoSectionPresentation on TodoSectionKind {
  String get label => switch (this) {
    .overdue => TodoMessages.sectionOverdue,
    .today => TodoMessages.sectionToday,
    .upcoming => TodoMessages.sectionUpcoming,
    .noDate => TodoMessages.sectionNoDate,
    .completed => TodoMessages.sectionCompleted,
  };
}
