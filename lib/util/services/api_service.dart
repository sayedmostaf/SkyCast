import 'dart:convert';

import 'package:sky_cast/core/app_config.dart';
import 'package:http/http.dart' as http;

class ApiService {
  getRequst({required String endPoint}) async {
    String fullUrl = AppConfig.baseUrl + endPoint;
    http.Response response = await http.get(Uri.parse(fullUrl));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }

  postRequst({required String endPoint, data}) async {
    String fullUrl = AppConfig.baseUrl + endPoint;
    http.Response response = await http.post(Uri.parse(fullUrl), body: data);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }
}
