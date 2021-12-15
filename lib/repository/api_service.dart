import 'dart:convert';
import 'dart:io';

import 'package:flutter_image_loading/repository/api/api_exception.dart';
import 'package:flutter_image_loading/utils/app_constants.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static String _url = "https://pixabay.com/api/?key=${AppConstants.LITERAL_API_KEY}&q=${AppConstants.LITERAL_SEARCH_TERM}&image_type=photo";
  static String _pagination = "&page=${AppConstants.LITERAL_PAGE}&per_page=${AppConstants.LITERAL_PER_PAGE}";

  static Future<dynamic> getImages() async {
    var responseJson;
    try {
      final response = await http.get(Uri.parse(_url));
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  static dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException('Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
