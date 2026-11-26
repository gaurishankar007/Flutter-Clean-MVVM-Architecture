import 'dart:async';

import 'package:clean_architecture/core/clients/remote/connectivity_client.dart';
import 'package:clean_architecture/ui/core/providers/base/base_notifier.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Whether the device is online, for the offline banner.
class ConnectivityNotifier extends BaseNotifier<bool> {
  @override
  bool build() {
    final client = GetIt.I<ConnectivityClient>();
    final subscription = client.onConnectivityChanged.listen(
      (connected) => state = connected,
    );
    ref.onDispose(() => unawaited(subscription.cancel()));
    return client.isConnected;
  }
}

final connectivityProvider = NotifierProvider(ConnectivityNotifier.new);
