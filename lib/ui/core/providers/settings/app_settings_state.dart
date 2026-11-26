import 'package:clean_architecture/domain/models/app_settings.dart';
import 'package:clean_architecture/ui/core/providers/base/base_notifier.dart';

final class const AppSettingsState({
  required final AppSettings settings,
  super.message,
}) extends BaseState {
  @override
  List<Object?> get props => [...super.props, settings];
}
