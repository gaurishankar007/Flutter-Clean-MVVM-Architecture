import 'package:clean_architecture/ui/core/providers/base/base_notifier.dart';

final class const {{notifier.pascalCase()}}State({super.status, super.message}) extends BaseState {
  {{notifier.pascalCase()}}State copyWith({StateStatus? status, StateMessage? message}) =>
      // Never keep the previous message: each one is shown once.
      {{notifier.pascalCase()}}State(status: status ?? this.status, message: message);
}
