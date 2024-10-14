import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sky_cast/controller/settings_controller.dart';
import 'package:sky_cast/core/themes/app_themes.dart';
import 'package:sky_cast/models/api_response.dart';
import 'package:sky_cast/models/current_weather_model.dart';
import 'package:sky_cast/models/forecast_model.dart';
import 'package:sky_cast/util/services/api_service.dart';

class WeatherController extends GetxController {
  final ApiService apiService = ApiService();
  final GetStorage box = GetStorage();
  String location = 'Paris';
  RxBool isLoading = false.obs;
  CurrentWeatherModel? currentWeather;
  ForecastModel? forecastModel;
  PageController outlookPageController = PageController();
  int currentOutlookPage = 0;
  Color? backgroundColor;
  late ApiResponse responseState;
  SettingsController settingsController = Get.find<SettingsController>();
  Timer? timer;

  Future<void> getWeatherData(String location) async {
    isLoading(true);
    var response = await apiService.getRequst(endPoint: '&q=$location');

    if (response.isRight()) {
      responseState = ApiResponse.ok;
      Map<String, dynamic> jsonResponse = response.getOrElse(() => {});
      currentWeather = CurrentWeatherModel.fromJson(jsonResponse);
      forecastModel = ForecastModel.fromJson(jsonResponse);
      box.write('location', location);
      this.location = location;
      updateBackgroundColor();
    } else {
      responseState = response.fold((l) => l, (r) => ApiResponse.unknownError);
    }
    isLoading(false);
    update();
  }

  Future<void> refreshWeather() async {
    await getWeatherData(location);
  }

  void onOutlookPageChange(index) {
    currentOutlookPage = index;
    update();
  }

  void updateBackgroundColor() {
    if (currentWeather!.current!.isDay == 1) {
      backgroundColor = AppThemes.dayBackground;
    } else {
      backgroundColor = AppThemes.nightBackground;
    }
  }

  void autoRefresh() {
    if (settingsController.refreshTime.inHours != 0) {
      timer = Timer.periodic(
        settingsController.refreshTime,
        (t) => refreshWeather(),
      );
    }
  }

  @override
  void onInit() async {
    isLoading(true);
    location = box.read('location') ?? location;
    await getWeatherData(location);
    autoRefresh();
    super.onInit();
  }
}
