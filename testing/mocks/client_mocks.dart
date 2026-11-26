import 'package:clean_architecture/core/clients/remote/connectivity_client.dart';
import 'package:clean_architecture/core/clients/remote/http/http_client.dart';
import 'package:clean_architecture/core/errors/error_recorders/app_error_recorder.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements HttpClient;

class MockConnectivityClient extends Mock implements ConnectivityClient;

class MockAppErrorRecorder extends Mock implements AppErrorRecorder;
