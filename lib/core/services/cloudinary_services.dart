import 'dart:io';

import 'package:dio/dio.dart';

class CloudinaryServices {
  CloudinaryServices._();

  static const String cloudName = "kyl67cpo";

  static const String uploadPreset = "m_store_unsigned";

  static Future<String> uploadImage(File image) async {
    final dio = Dio();

    final formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(image.path),
      "upload_preset": uploadPreset,
    });

    final response = await dio.post(
      "https://api.cloudinary.com/v1_1/$cloudName/image/upload",
      data: formData,
    );

    return response.data["secure_url"];
  }

  static Future<List<String>> uploadImages(
      List<File> images,
      ) async {
    List<String> urls = [];

    for (final image in images) {
      final url = await uploadImage(image);

      urls.add(url);
    }

    return urls;
  }
}