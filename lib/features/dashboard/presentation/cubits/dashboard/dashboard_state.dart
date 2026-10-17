part of 'dashboard_cubit.dart';

class const DashboardState({required final int activeIndex}) extends BaseState {
  factory initial() => const DashboardState(activeIndex: 0);

  DashboardState copyWith({int? activeIndex}) =>
      DashboardState(activeIndex: activeIndex ?? this.activeIndex);

  @override
  List<Object> get props => [activeIndex];
}
