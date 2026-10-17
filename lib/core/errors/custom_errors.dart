///
class const WebCameraException({final String? message, final String? error})
    implements Exception {
  @override
  String toString() => 'WebCameraException(message: $message, error: $error)';
}
