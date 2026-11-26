import 'package:clean_architecture/ui/core/providers/base/base_notifier.dart';

final class const SettingsState({
  super.status,
  super.message,
  final String? version,
}) extends BaseState {
  SettingsState copyWith({StateMessage? message, String? version}) =>
      SettingsState(
        status: status,
        message: message,
        version: version ?? this.version,
      );

  @override
  List<Object?> get props => [...super.props, version];
}
