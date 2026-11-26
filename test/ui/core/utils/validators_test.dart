import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/ui/core/utils/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('required', () {
    expect(Validators.required('  '), ValidationMessages.required);
    expect(Validators.required('a'), isNull);
  });

  test('email', () {
    expect(Validators.email('nope'), ValidationMessages.invalidEmail);
    expect(Validators.email('a@b.co'), isNull);
  });

  test('phone is optional', () {
    expect(Validators.phone(''), isNull);
    expect(Validators.phone('+1 (555) 123-4567'), isNull);
    expect(Validators.phone('abc'), ValidationMessages.invalidPhone);
  });
}
