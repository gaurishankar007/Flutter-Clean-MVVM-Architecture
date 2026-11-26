import 'package:clean_architecture/domain/repositories/app_info_repository.dart';
import 'package:clean_architecture/domain/repositories/auth_repository.dart';
import 'package:clean_architecture/domain/repositories/error_log_repository.dart';
import 'package:clean_architecture/domain/repositories/notification_repository.dart';
import 'package:clean_architecture/domain/repositories/settings_repository.dart';
import 'package:clean_architecture/domain/repositories/todo_repository.dart';
import 'package:clean_architecture/domain/repositories/user_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository;

class MockUserRepository extends Mock implements UserRepository;

class MockTodoRepository extends Mock implements TodoRepository;

class MockNotificationRepository extends Mock implements NotificationRepository;

class MockSettingsRepository extends Mock implements SettingsRepository;

class MockErrorLogRepository extends Mock implements ErrorLogRepository;

class MockAppInfoRepository extends Mock implements AppInfoRepository;
