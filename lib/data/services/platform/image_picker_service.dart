import 'package:clean_architecture/core/data/states/data_state.dart';
import 'package:clean_architecture/core/errors/error_handler.dart';
import 'package:clean_architecture/core/types/types.dart';
import 'package:flutter/foundation.dart' show Uint8List;
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

@module
abstract class ImagePickerModule {
  @lazySingleton
  ImagePicker get imagePicker => ImagePicker();
}

/// Picks a photo from the gallery as bytes (works on mobile and web).
@lazySingleton
class ImagePickerService({required final ImagePicker _picker}) {
  FutureData<Uint8List?> pickFromGallery() =>
      ErrorHandlerProvider.I.execute(() async {
        final file = await _picker.pickImage(
          source: .gallery,
          maxWidth: 512,
          maxHeight: 512,
          imageQuality: 80,
        );
        return SuccessState(data: await file?.readAsBytes(), origin: .local);
      }, action: 'platform.pickImage');
}
