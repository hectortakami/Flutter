import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ImagePickerProvider {
  final ImagePicker _picker = ImagePicker();

  Future<String?> selectFromGallery() async {
    String? imagePath;
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );
    if (photo?.path != null) {
      imagePath = photo!.path;
    }
    if (imagePath != null) {
      return imagePath;
    } else {
      return null;
    }
  }

  Future<String> uploadToCloudinary(String imagePath) async {
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/katana-sys/image/upload?upload_preset=flutter_demo');
    final file = await http.MultipartFile.fromPath('file', imagePath);
    final cloudinaryRequest = http.MultipartRequest('POST', url);
    cloudinaryRequest.files.add(file);

    final streamResponse = await cloudinaryRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    final decodeData = json.decode(resp.body); // Entire Cloudinary response
    return decodeData['secure_url'];
  }
}
