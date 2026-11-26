part of 'base_notifier.dart';

/// Where a screen is: idle, loading, loaded, error, or refreshing (loaded
/// data on screen while new data loads).
enum StateStatus { idle, loading, loaded, error, refreshing }

/// A one-shot message the View shows with `ToastUtil`, carried on
/// [BaseState.message].
///
/// A state's `copyWith` must never keep the previous message
/// (`message: message`, never `message ?? this.message`), so each message is
/// shown once. Subclasses stay `Equatable` so tests can compare them.
sealed class const StateMessage(final String text) extends Equatable {
  @override
  List<Object?> get props => [text];
}

class const SuccessMessage(super.text) extends StateMessage;

class const ErrorMessage(super.text) extends StateMessage;

class const WarningMessage(super.text) extends StateMessage;

/// Neutral information (neither success, error nor warning).
class const NormalMessage(super.text) extends StateMessage;

/// Base state for notifiers.
abstract class const BaseState({
  final StateStatus status = .idle,
  final StateMessage? message,
}) extends Equatable {
  bool get isLoading => status == .loading;

  @override
  List<Object?> get props => [status, message];
}
