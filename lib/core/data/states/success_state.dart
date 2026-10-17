part of 'data_state.dart';

/// A success data state when there is no any error and data is available
final class const SuccessState<T>({
  required super.data,
  super.message,
  super.extra,
}) extends DataState<T> {
  this : super(hasData: true);

  /// A success data state when there is no any error and data is null
  static const nil = SuccessState<void>(data: null);
}
