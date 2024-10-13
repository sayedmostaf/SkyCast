import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sky_cast/models/current_weather_model.dart';
import 'package:sky_cast/models/forecast_model.dart';
import 'package:sky_cast/util/helpers/app_helper.dart';
import 'package:sky_cast/util/services/api_service.dart';

class WeatherController extends GetxController {
  final ApiService apiService = ApiService();
  late SharedPreferences sharedPreferences;
  String location = 'Paris';
  RxBool isLoading = false.obs;
  CurrentWeatherModel? currentWeather;
  ForecastModel? forecastModel;
  PageController outlookPageController = PageController();
  int currentOutlookPage = 0;
  Future<void> getWeatherData(String location) async {
    isLoading(true);
    var response = await apiService.getRequst(endPoint: '&q=$location');

    try {
      if (response != null) {
        print(response.toString());
        currentWeather = CurrentWeatherModel.fromJson(response);
        forecastModel = ForecastModel.fromJson(response);
        await sharedPreferences.setString('location', location);
        this.location = location;
      } else {
        AppHelper.showSnackbar(title: 'Error', message: 'Incorrect location');
        return;
      }
    } catch (_) {
      AppHelper.showSnackbar(
          title: 'Error', message: 'Failed to get location data.');
    } finally {
      isLoading(false);
      update();
    }
  }

  Future<void> refreshWeather() async {
    await getWeatherData(location);
  }

  void onOutlookPageChange(index) {
    currentOutlookPage = index;
    update();
  }

  @override
  void onInit() async {
    isLoading(true);
    sharedPreferences = await SharedPreferences.getInstance();
    location = sharedPreferences.getString('location') ?? location;
    await getWeatherData(location);
    super.onInit();
  }
}
