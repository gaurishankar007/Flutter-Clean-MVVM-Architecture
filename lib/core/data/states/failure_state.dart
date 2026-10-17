part of 'data_state.dart';

const String kCustomerSupport = 'Please contact our customer support.';
const String kErrorMessage = 'Unexpected error occurred. $kCustomerSupport';
const String kCheckInternet = 'Please check your internet and try again.';
const String kNoInternet = 'No internet access. Please try again later.';

/// A failure data state when error occurs
final class const FailureState<T>({String? message, super.error, super.extra})
    extends DataState<T> {
  this : super(message: message ?? kErrorMessage, hasError: true);

  /// A failure data state when invalid data is provided to the server
  factory badRequest({String? message, String? error, dynamic extra}) =>
      FailureState(
        message: message ?? 'Bad client request. Please try again',
        error: error,
        extra: extra,
      );

  /// A failure data state when the user's token is expired
  factory tokenExpired() =>
      const FailureState(message: 'Token expired, login again.');

  /// A failure data state when the response of the server is invalid
  factory badResponse({String? message, String? error, dynamic extra}) =>
      FailureState(
        message: message ?? 'Bad server response.',
        error: error,
        extra: extra,
      );

  /// A failure data state when error occurs in the server
  factory serverError({String? message, String? error, dynamic extra}) =>
      FailureState(
        message: message ?? 'Server error occurred. $kCustomerSupport',
        error: error,
        extra: extra,
      );

  /// A failure data state when there is no internet access
  factory noInternet() =>
      const FailureState(message: kNoInternet, error: kNoInternet);
}
