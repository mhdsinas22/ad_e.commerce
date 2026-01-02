import 'dart:io';

import 'package:ad_e_commerce/core/config/cloudinary_config.dart';
import 'package:dio/dio.dart';

class CloudinaryRemoteDatasource {
  final Dio _dio;

  CloudinaryRemoteDatasource({Dio? dio}) : _dio = dio ?? Dio();

  Future<String> uploadImage(File file) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(file.path),
        'upload_preset': CloudinaryConfig.uploadPreset,
      });

      final response = await _dio.post(
        CloudinaryConfig.uploadUrl,
        data: formData,
      );

      if (response.statusCode == 200 && response.data['secure_url'] != null) {
        return response.data['secure_url'] as String;
      } else {
        throw Exception('Cloudinary upload failed');
      }
    }
    // 🔴 Dio specific errors (network, timeout, 4xx, 5xx)
    on DioException catch (e) {
      if (e.response != null) {
        throw Exception(
          'Cloudinary error: ${e.response?.statusCode} - ${e.response?.data}',
        );
      } else {
        throw Exception('Network error while uploading image');
      }
    }
    // 🔴 Any other unexpected error
    catch (e) {
      throw Exception('Unexpected error while uploading image');
    }
  }
}
