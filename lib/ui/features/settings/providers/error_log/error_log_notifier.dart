import 'dart:async';

import 'package:clean_architecture/core/data/states/data_state.dart';
import 'package:clean_architecture/domain/repositories/error_log_repository.dart';
import 'package:clean_architecture/ui/core/providers/base/base_notifier.dart';
import 'package:clean_architecture/ui/features/settings/providers/error_log/error_log_state.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ErrorLogNotifier extends BaseNotifier<ErrorLogState> {
  late final ErrorLogRepository _repository;

  @override
  ErrorLogState build() {
    _repository = GetIt.I<ErrorLogRepository>();
    final subscription = _repository.watchEntries().listen((result) {
      // Not tracked: a failure reading the error log would log itself.
      state = ErrorLogState(
        status: result is SuccessState ? .loaded : .error,
        entries: result.data ?? state.entries,
      );
    });
    ref.onDispose(() => unawaited(subscription.cancel()));
    return const ErrorLogState();
  }

  Future<void> clear() => _repository.clear();
}

final errorLogProvider = NotifierProvider.autoDispose(ErrorLogNotifier.new);
