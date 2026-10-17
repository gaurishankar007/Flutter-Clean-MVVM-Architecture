part of 'screen_observer_cubit.dart';

/// Holds state related to screen layout changes.
class const ScreenObserverState({
  /// The current screen width.
  required final double width,

  /// The current screen height.
  required final double height,

  /// Increments only when the [ScreenType] changes.
  required final int screenTypeChanges,

  /// Increments only when switching between desktop and non-desktop layouts.
  required final int desktopLayoutChanges,
}) extends Equatable {
  factory initial() => const ScreenObserverState(
    width: 0,
    height: 0,
    screenTypeChanges: 0,
    desktopLayoutChanges: 0,
  );

  ScreenObserverState copyWith({
    double? width,
    double? height,
    int? screenTypeChanges,
    int? desktopLayoutChanges,
  }) {
    return ScreenObserverState(
      width: width ?? this.width,
      height: height ?? this.height,
      screenTypeChanges: screenTypeChanges ?? this.screenTypeChanges,
      desktopLayoutChanges: desktopLayoutChanges ?? this.desktopLayoutChanges,
    );
  }

  @override
  List<Object?> get props => [
    width,
    height,
    screenTypeChanges,
    desktopLayoutChanges,
  ];
}
