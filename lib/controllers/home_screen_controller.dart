import 'package:flutter/material.dart';
import 'package:flutter_image_loading/models/image_response_models.dart';
import 'package:flutter_image_loading/repository/api/api_response.dart';
import 'package:flutter_image_loading/repository/api_repository.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  RxList _imageList = <ImageHits>[].obs;

  RxList<ImageHits> get imageList => RxList.unmodifiable(_imageList);

  int _currentPageOffset = 1;

  getMoreImages(String searchTerm) async {
    final response = await ApiRepository().fetchImages(searchTerm, _currentPageOffset);
    if (response.data != null && response.data is ImageApiResponse) {
      _currentPageOffset++;
      final apiResponse = response.data as ImageApiResponse;
      debugPrint("SUCCESS :::: ");
      if (apiResponse.hits.isNotEmpty) {
        _imageList.assignAll(apiResponse.hits);
      }
    } else if (response.status == Status.ERROR) {
      debugPrint("ERROR :::: ");
    }
    update();
  }
}
