import 'package:image_picker/image_picker.dart';

class ImageService {
  static final ImagePicker picker = ImagePicker();

  static Future<XFile?> pickImage(ImageUploadType type) async {
    XFile? pickedFile;
    if (type == ImageUploadType.camera) {
      pickedFile = await _pickCamera();
    } else {
      pickedFile = await _pickGallery();
    }
    if (pickedFile == null) {
      return null;
    }
    return pickedFile;
  }

  static Future<XFile?> _pickCamera() async {
    var pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile == null) {
      return null;
    }
    return pickedFile;
  }

  static Future<XFile?> _pickGallery() async {
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      return null;
    }
    return pickedFile;
  }
}

enum ImageUploadType { camera, gallery }
