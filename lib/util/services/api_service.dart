import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:sky_cast/core/config/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:sky_cast/models/api_response.dart';
import 'package:sky_cast/util/helpers/app_helper.dart';

class ApiService {
  Future<Either<ApiResponse, dynamic>> getRequst({
    required String endPoint,
    bool isSearch = false,
  }) async {
    String fullUrl = AppConfig.baseUrl + endPoint;
    if (isSearch) {
      fullUrl = AppConfig.searchUrl + endPoint;
    }
    bool isOnline = await AppHelper.checkInternet();

    try {
      if (isOnline) {
        http.Response response = await http.get(Uri.parse(fullUrl));
        if (response.statusCode == 200 || response.statusCode == 201) {
          return Right(jsonDecode(response.body));
        } else if (response.statusCode == 400) {
          return const Left(ApiResponse.wrongLocation);
        } else {
          return const Left(ApiResponse.serverError);
        }
      } else {
        return const Left(ApiResponse.offline);
      }
    } catch (_) {
      return const Left(ApiResponse.unknownError);
    }
  }
}
