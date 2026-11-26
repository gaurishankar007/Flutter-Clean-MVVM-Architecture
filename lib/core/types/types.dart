import 'dart:async';

import 'package:clean_architecture/core/data/states/data_state.dart';

/// An asynchronous operation that completes with a [DataState] of [T].
typedef FutureData<T> = Future<DataState<T>>;

/// An asynchronous operation that completes with a [DataState] of a list.
typedef FutureList<T> = Future<DataState<List<T>>>;

/// An asynchronous operation whose caller only checks success or failure.
typedef FutureVoid = Future<DataState<void>>;

/// A stream of [DataState]s of [T].
typedef StreamData<T> = Stream<DataState<T>>;

/// A decoded JSON object.
typedef JsonMap = Map<String, dynamic>;
