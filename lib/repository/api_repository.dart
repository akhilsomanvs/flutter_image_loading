import 'package:flutter_image_loading/models/image_response_models.dart';
import 'package:flutter_image_loading/repository/api/api_response.dart';
import 'package:flutter_image_loading/repository/api_service.dart';

class ApiRepository {
  Future<ApiResponse> fetchImages() async {
    try {
      final response = await ApiService.getImages();
      return ApiResponse.completed(ImageApiResponse.fromJson(response));
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }
}
