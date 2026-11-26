import 'package:clean_architecture/core/data/states/data_state.dart';
import 'package:clean_architecture/core/errors/error_flow.dart';
import 'package:clean_architecture/core/errors/error_recorders/app_error_recorder.dart';
import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:equatable/equatable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'base_state.dart';
part 'error_tracking.dart';

/// Base ViewModel for synchronous state.
abstract class BaseNotifier<T> extends Notifier<T> with ErrorTracking;

/// Base ViewModel whose first state loads asynchronously.
abstract class BaseAsyncNotifier<T> extends AsyncNotifier<T> with ErrorTracking;

/// Base ViewModel whose state comes from a stream.
abstract class BaseStreamNotifier<T> extends StreamNotifier<T>
    with ErrorTracking;
