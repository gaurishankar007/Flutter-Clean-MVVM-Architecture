import 'package:clean_architecture/core/types/types.dart';

/// A use case taking one [P] parameter. Use cases are optional: add one only
/// when a flow combines several repositories or has logic worth reusing.
abstract interface class UseCase1<T, P extends Object?> {
  FutureData<T> call(P parameter);
}

/// A use case without parameters.
abstract interface class UseCase0<T> {
  FutureData<T> call();
}
