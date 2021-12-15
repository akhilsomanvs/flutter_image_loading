import 'package:flutter_image_loading/models/image_response_models.dart';
import 'package:flutter_image_loading/repository/api/api_response.dart';
import 'package:flutter_image_loading/repository/api_repository.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  final RxList _imageList = <dynamic>[].obs;

  RxList<dynamic> get imageList => RxList.unmodifiable(_imageList);

  int _currentPageOffset = 1;

  final _ImageLoading imageLoadingObject = _ImageLoading();
  bool isLoading = false;

  getMoreImages(String searchTerm) async {
    _imageList.add(imageLoadingObject);
    if (isLoading) {
      return;
    }
    isLoading = true;
    update();
    final response = await ApiRepository().fetchImages(searchTerm, _currentPageOffset);
    if (response.data != null && response.data is ImageApiResponse) {
      _imageList.remove(imageLoadingObject);

      _currentPageOffset++;
      final apiResponse = response.data as ImageApiResponse;
      if (apiResponse.hits.isNotEmpty) {
        _imageList.addAll(apiResponse.hits);
      }
    } else if (response.status == Status.ERROR) {}
    isLoading = false;
    update();
  }

  void clearImageList() {
    _imageList.clear();
    update();
  }
}

class _ImageLoading {}
