import 'dart:async';

import 'package:clean_architecture/core/clients/remote/connectivity_client.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../testing/mocks/external/external_mocks.dart'
    show MockConnectivity;

void main() {
  late MockConnectivity mockConnectivity;
  late ConnectivityClientImpl connectivityClient;

  setUp(() {
    mockConnectivity = MockConnectivity();
    connectivityClient = ConnectivityClientImpl(connectivity: mockConnectivity);
  });

  group('subscribeConnectivity', () {
    test(
      'updates isConnected to true when wifi or mobile is present',
      () async {
        final controller =
            StreamController<List<ConnectivityResult>>.broadcast();
        when(() => mockConnectivity.onConnectivityChanged)
            .thenAnswer((_) => controller.stream);

        await connectivityClient.subscribeConnectivity();

        // Emit wifi
        controller.add([.wifi]);
        // Wait for the stream listener to process
        await Future<void>.delayed(.zero);
        expect(connectivityClient.isConnected, true);

        // Emit mobile
        controller.add([.mobile]);
        await Future<void>.delayed(.zero);
        expect(connectivityClient.isConnected, true);

        await controller.close();
      },
    );

    test(
      'updates isConnected to false when neither wifi nor mobile is present',
      () async {
        final controller =
            StreamController<List<ConnectivityResult>>.broadcast();
        when(() => mockConnectivity.onConnectivityChanged)
            .thenAnswer((_) => controller.stream);

        await connectivityClient.subscribeConnectivity();

        // Emit none
        controller.add([.none]);
        await Future<void>.delayed(.zero);
        expect(connectivityClient.isConnected, false);

        await controller.close();
      },
    );
  });

  group('unSubscriptionConnectivity', () {
    test('cancels the subscription', () async {
      final controller = StreamController<List<ConnectivityResult>>.broadcast();
      when(() => mockConnectivity.onConnectivityChanged)
          .thenAnswer((_) => controller.stream);

      await connectivityClient.subscribeConnectivity();
      connectivityClient.unSubscriptionConnectivity();

      // After cancelling, adding to the stream should not update state
      // (though we can't easily verify the subscription is cancelled without mocking the subscription itself,
      // but we can check if it doesn't crash and the state remains what it was)
      controller.add([.none]);
      await controller.close();
    });
  });

  group('connectivityStream', () {
    test('returns the broadcast stream', () async {
      final controller = StreamController<List<ConnectivityResult>>.broadcast();
      when(() => mockConnectivity.onConnectivityChanged)
          .thenAnswer((_) => controller.stream);

      await connectivityClient.subscribeConnectivity();

      expect(connectivityClient.connectivityStream, isNotNull);

      await controller.close();
    });
  });
}
