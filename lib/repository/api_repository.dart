import 'package:flutter_image_loading/models/image_response_models.dart';
import 'package:flutter_image_loading/repository/api/api_response.dart';
import 'package:flutter_image_loading/repository/api_service.dart';

class ApiRepository {
  Future<ApiResponse> fetchImages(String searchTerm, int page) async {
    try {
      final response = await ApiService.getImages(searchTerm, page);
      return ApiResponse.completed(ImageApiResponse.fromJson(response));
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }
}
