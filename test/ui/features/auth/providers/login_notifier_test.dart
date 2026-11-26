import 'package:clean_architecture/core/data/states/data_state.dart';
import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/domain/use_cases/login_use_case.dart';
import 'package:clean_architecture/ui/core/providers/base/base_notifier.dart';
import 'package:clean_architecture/ui/features/auth/providers/login/login_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../testing/helpers/fixtures.dart';
import '../../../../../testing/helpers/test_setup.dart';
import '../../../../../testing/mocks/client_mocks.dart';
import '../../../../../testing/mocks/use_case_mocks.dart';

void main() {
  late MockLoginUseCase loginUseCase;
  late MockAppErrorRecorder recorder;
  late ProviderContainer container;

  setUpAll(() {
    registerFallbackValue((username: '', password: ''));
    registerFallbackValue(const SuccessState<dynamic>(data: null));
  });

  setUp(() {
    recorder = registerErrorHandling();
    loginUseCase = MockLoginUseCase();
    registerMock<LoginUseCase>(loginUseCase);
    // Listening keeps the auto-dispose provider alive between reads.
    container = ProviderContainer.test()..listen(loginProvider, (_, _) {});
  });

  tearDown(resetDependencies);

  test('empty fields set errors and skip the use case', () async {
    final loggedIn = await container
        .read(loginProvider.notifier)
        .login(username: '', password: '');

    expect(loggedIn, isFalse);
    expect(
      container.read(loginProvider).usernameError,
      ValidationMessages.required,
    );
    expect(
      container.read(loginProvider).passwordError,
      ValidationMessages.required,
    );
    verifyNever(() => loginUseCase(any()));
  });

  test('success returns true with a success message', () async {
    when(() => loginUseCase(any()))
        .thenAnswer((_) async => const SuccessState(data: testUser));

    final loggedIn = await container
        .read(loginProvider.notifier)
        .login(username: 'emilys', password: 'emilyspass');

    expect(loggedIn, isTrue);
    expect(
      container.read(loginProvider).message,
      const SuccessMessage(AuthMessages.loggedIn),
    );
  });

  test('failure is tracked and shown', () async {
    const failure = FailureState<Never>(message: 'Invalid credentials');
    when(() => loginUseCase(any())).thenAnswer((_) async => failure.retype());

    final loggedIn = await container
        .read(loginProvider.notifier)
        .login(username: 'emilys', password: 'wrong');

    expect(loggedIn, isFalse);
    expect(
      container.read(loginProvider).message,
      const ErrorMessage('Invalid credentials'),
    );
    verify(
      () => recorder.trackFailure(
        any(),
        action: 'auth.login',
        source: 'LoginNotifier',
      ),
    ).called(1);
  });
}
