import 'package:flutter/widgets.dart';

/// Runs [callback] after the current frame. Riverpod rejects state changes
/// mid-build, so updates triggered by layout or metrics go through this.
void runAfterBuild(VoidCallback callback) =>
    WidgetsBinding.instance.addPostFrameCallback((_) => callback());
