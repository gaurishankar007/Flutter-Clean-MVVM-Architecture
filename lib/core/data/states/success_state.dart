part of 'data_state.dart';

/// A successful operation.
final class SuccessState<T> extends DataState<T> {
  const new({required super.data, super.message, super.origin, super.extra})
    : super(hasData: true);

  /// Success without a payload; the result of every `FutureVoid` method.
  const new nil({super.origin}) : super(data: null, hasData: true);
}
