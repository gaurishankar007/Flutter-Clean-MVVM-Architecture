import 'package:clean_architecture/core/messages/app_messages.dart';

/// Form validators. Each returns an error message, or null when valid.
abstract final class Validators {
  static final _email = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
  static final _phone = RegExp(r'^\+?[0-9 ()-]{7,20}$');

  static String? required(String? value) =>
      (value == null || value.trim().isEmpty)
      ? ValidationMessages.required
      : null;

  static String? email(String? value) => switch (value?.trim()) {
    null || '' => ValidationMessages.required,
    final text when !_email.hasMatch(text) => ValidationMessages.invalidEmail,
    _ => null,
  };

  /// Optional: an empty phone is valid.
  static String? phone(String? value) => switch (value?.trim()) {
    null || '' => null,
    final text when !_phone.hasMatch(text) => ValidationMessages.invalidPhone,
    _ => null,
  };

  static String? password(String? value) => switch (value) {
    null || '' => ValidationMessages.required,
    final text when text.length < 6 => ValidationMessages.passwordTooShort,
    _ => null,
  };
}
