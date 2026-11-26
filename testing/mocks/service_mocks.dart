import 'package:clean_architecture/data/services/local/notification_local_service.dart';
import 'package:clean_architecture/data/services/local/session_local_service.dart';
import 'package:clean_architecture/data/services/local/settings_local_service.dart';
import 'package:clean_architecture/data/services/local/todo_local_service.dart';
import 'package:clean_architecture/data/services/platform/image_picker_service.dart';
import 'package:clean_architecture/data/services/remote/auth_api_service.dart';
import 'package:clean_architecture/data/services/remote/todo_api_service.dart';
import 'package:clean_architecture/data/services/remote/user_api_service.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthApiService extends Mock implements AuthApiService;

class MockUserApiService extends Mock implements UserApiService;

class MockTodoApiService extends Mock implements TodoApiService;

class MockSessionLocalService extends Mock implements SessionLocalService;

class MockSettingsLocalService extends Mock implements SettingsLocalService;

class MockTodoLocalService extends Mock implements TodoLocalService;

class MockNotificationLocalService extends Mock
    implements NotificationLocalService;

class MockImagePickerService extends Mock implements ImagePickerService;
