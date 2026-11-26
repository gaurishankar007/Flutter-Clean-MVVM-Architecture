import 'package:clean_architecture/domain/use_cases/login_use_case.dart';
import 'package:clean_architecture/domain/use_cases/logout_use_case.dart';
import 'package:clean_architecture/domain/use_cases/save_todo_use_case.dart';
import 'package:clean_architecture/domain/use_cases/set_todo_completed_use_case.dart';
import 'package:clean_architecture/domain/use_cases/sync_todos_use_case.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginUseCase extends Mock implements LoginUseCase;

class MockLogoutUseCase extends Mock implements LogoutUseCase;

class MockSyncTodosUseCase extends Mock implements SyncTodosUseCase;

class MockSaveTodoUseCase extends Mock implements SaveTodoUseCase;

class MockSetTodoCompletedUseCase extends Mock
    implements SetTodoCompletedUseCase;
