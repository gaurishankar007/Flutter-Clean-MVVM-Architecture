import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';

/// Whether the device has a network connection.
abstract interface class ConnectivityClient {
  bool get isConnected;

  /// Emits on every change.
  Stream<bool> get onConnectivityChanged;

  /// Reads the current state and starts listening. Called at startup.
  Future<void> initialize();
}

@module
abstract class ConnectivityModule {
  @lazySingleton
  Connectivity get connectivity => Connectivity();
}

@LazySingleton(as: ConnectivityClient)
final class ConnectivityClientImpl({required final Connectivity _connectivity})
    implements ConnectivityClient {
  final _controller = StreamController<bool>.broadcast();
  StreamSubscription<List<ConnectivityResult>>? _subscription;
  bool _isConnected = true;

  @override
  bool get isConnected => _isConnected;

  @override
  Stream<bool> get onConnectivityChanged => _controller.stream;

  @override
  Future<void> initialize() async {
    _update(await _connectivity.checkConnectivity());
    _subscription ??= _connectivity.onConnectivityChanged.listen(_update);
  }

  void _update(List<ConnectivityResult> results) {
    final connected = results.any((r) => r != ConnectivityResult.none);
    if (connected != _isConnected) {
      _isConnected = connected;
      _controller.add(connected);
    }
  }
}
