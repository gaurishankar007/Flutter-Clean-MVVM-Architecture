// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:auto_route/auto_route.dart' as _i13;
import 'package:clean_architecture/ui/features/auth/views/login/login_screen.dart'
    as _i4;
import 'package:clean_architecture/ui/features/home/views/home_shell/home_shell_screen.dart'
    as _i3;
import 'package:clean_architecture/ui/features/notifications/views/notifications/notifications_screen.dart'
    as _i5;
import 'package:clean_architecture/ui/features/onboarding/views/onboarding/onboarding_screen.dart'
    as _i6;
import 'package:clean_architecture/ui/features/profile/views/edit_profile/edit_profile_screen.dart'
    as _i1;
import 'package:clean_architecture/ui/features/profile/views/profile/profile_screen.dart'
    as _i7;
import 'package:clean_architecture/ui/features/settings/views/error_log/error_log_screen.dart'
    as _i2;
import 'package:clean_architecture/ui/features/settings/views/settings/settings_screen.dart'
    as _i8;
import 'package:clean_architecture/ui/features/startup/views/splash/splash_screen.dart'
    as _i9;
import 'package:clean_architecture/ui/features/todos/views/todo_detail/todo_detail_screen.dart'
    as _i10;
import 'package:clean_architecture/ui/features/todos/views/todo_editor/todo_editor_screen.dart'
    as _i11;
import 'package:clean_architecture/ui/features/todos/views/todos/todos_screen.dart'
    as _i12;
import 'package:material_ui/material_ui.dart' as _i14;

/// generated route for
/// [_i1.EditProfileScreen]
class EditProfileRoute extends _i13.PageRouteInfo<void> {
  const EditProfileRoute({List<_i13.PageRouteInfo>? children})
    : super(EditProfileRoute.name, initialChildren: children);

  static const String name = 'EditProfileRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i1.EditProfileScreen();
    },
  );
}

/// generated route for
/// [_i2.ErrorLogScreen]
class ErrorLogRoute extends _i13.PageRouteInfo<void> {
  const ErrorLogRoute({List<_i13.PageRouteInfo>? children})
    : super(ErrorLogRoute.name, initialChildren: children);

  static const String name = 'ErrorLogRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i2.ErrorLogScreen();
    },
  );
}

/// generated route for
/// [_i3.HomeShellScreen]
class HomeShellRoute extends _i13.PageRouteInfo<void> {
  const HomeShellRoute({List<_i13.PageRouteInfo>? children})
    : super(HomeShellRoute.name, initialChildren: children);

  static const String name = 'HomeShellRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i3.HomeShellScreen();
    },
  );
}

/// generated route for
/// [_i4.LoginScreen]
class LoginRoute extends _i13.PageRouteInfo<void> {
  const LoginRoute({List<_i13.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i4.LoginScreen();
    },
  );
}

/// generated route for
/// [_i5.NotificationsScreen]
class NotificationsRoute extends _i13.PageRouteInfo<void> {
  const NotificationsRoute({List<_i13.PageRouteInfo>? children})
    : super(NotificationsRoute.name, initialChildren: children);

  static const String name = 'NotificationsRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i5.NotificationsScreen();
    },
  );
}

/// generated route for
/// [_i6.OnboardingScreen]
class OnboardingRoute extends _i13.PageRouteInfo<void> {
  const OnboardingRoute({List<_i13.PageRouteInfo>? children})
    : super(OnboardingRoute.name, initialChildren: children);

  static const String name = 'OnboardingRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i6.OnboardingScreen();
    },
  );
}

/// generated route for
/// [_i7.ProfileScreen]
class ProfileRoute extends _i13.PageRouteInfo<void> {
  const ProfileRoute({List<_i13.PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i7.ProfileScreen();
    },
  );
}

/// generated route for
/// [_i8.SettingsScreen]
class SettingsRoute extends _i13.PageRouteInfo<void> {
  const SettingsRoute({List<_i13.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i8.SettingsScreen();
    },
  );
}

/// generated route for
/// [_i9.SplashScreen]
class SplashRoute extends _i13.PageRouteInfo<void> {
  const SplashRoute({List<_i13.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i9.SplashScreen();
    },
  );
}

/// generated route for
/// [_i10.TodoDetailScreen]
class TodoDetailRoute extends _i13.PageRouteInfo<TodoDetailRouteArgs> {
  TodoDetailRoute({
    _i14.Key? key,
    required String todoId,
    List<_i13.PageRouteInfo>? children,
  }) : super(
         TodoDetailRoute.name,
         args: TodoDetailRouteArgs(key: key, todoId: todoId),
         rawPathParams: {'todoId': todoId},
         initialChildren: children,
       );

  static const String name = 'TodoDetailRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<TodoDetailRouteArgs>(
        orElse: () =>
            TodoDetailRouteArgs(todoId: pathParams.getString('todoId')),
      );
      return _i10.TodoDetailScreen(key: args.key, todoId: args.todoId);
    },
  );
}

class TodoDetailRouteArgs {
  const TodoDetailRouteArgs({this.key, required this.todoId});

  final _i14.Key? key;

  final String todoId;

  @override
  String toString() {
    return 'TodoDetailRouteArgs{key: $key, todoId: $todoId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! TodoDetailRouteArgs) return false;
    return key == other.key && todoId == other.todoId;
  }

  @override
  int get hashCode => key.hashCode ^ todoId.hashCode;
}

/// generated route for
/// [_i11.TodoEditorScreen]
class TodoEditorRoute extends _i13.PageRouteInfo<TodoEditorRouteArgs> {
  TodoEditorRoute({
    _i14.Key? key,
    String? todoId,
    List<_i13.PageRouteInfo>? children,
  }) : super(
         TodoEditorRoute.name,
         args: TodoEditorRouteArgs(key: key, todoId: todoId),
         rawQueryParams: {'id': todoId},
         initialChildren: children,
       );

  static const String name = 'TodoEditorRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      final queryParams = data.queryParams;
      final args = data.argsAs<TodoEditorRouteArgs>(
        orElse: () => TodoEditorRouteArgs(todoId: queryParams.optString('id')),
      );
      return _i11.TodoEditorScreen(key: args.key, todoId: args.todoId);
    },
  );
}

class TodoEditorRouteArgs {
  const TodoEditorRouteArgs({this.key, this.todoId});

  final _i14.Key? key;

  final String? todoId;

  @override
  String toString() {
    return 'TodoEditorRouteArgs{key: $key, todoId: $todoId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! TodoEditorRouteArgs) return false;
    return key == other.key && todoId == other.todoId;
  }

  @override
  int get hashCode => key.hashCode ^ todoId.hashCode;
}

/// generated route for
/// [_i12.TodosScreen]
class TodosRoute extends _i13.PageRouteInfo<void> {
  const TodosRoute({List<_i13.PageRouteInfo>? children})
    : super(TodosRoute.name, initialChildren: children);

  static const String name = 'TodosRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i12.TodosScreen();
    },
  );
}
