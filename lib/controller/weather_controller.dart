import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sky_cast/controller/settings_controller.dart';
import 'package:sky_cast/core/config/app_routes.dart';
import 'package:sky_cast/core/themes/app_themes.dart';
import 'package:sky_cast/models/api_response.dart';
import 'package:sky_cast/models/search_location.dart';
import 'package:sky_cast/models/weather.dart';
import 'package:sky_cast/util/services/api_service.dart';

class WeatherController extends GetxController {
  final ApiService apiService = ApiService();
  final GetStorage box = GetStorage();
  String location = 'Paris';
  RxBool isLoading = false.obs;
  PageController outlookPageController = PageController();
  int currentOutlookPage = 0;
  Color? backgroundColor;
  late ApiResponse responseState;
  Rx<ApiResponse> searchState = ApiResponse.unknownError.obs;
  SettingsController settingsController = Get.find<SettingsController>();
  Timer? timer;
  RxList<Weather> weathers = <Weather>[].obs;
  RxList<SearchLocation> searchLocations = <SearchLocation>[].obs;

  Future<void> getWeatherData(String location) async {
    isLoading(true);
    var response = await apiService.getRequst(endPoint: '&q=$location');

    if (response.isRight()) {
      responseState = ApiResponse.ok;
      Map<String, dynamic> jsonResponse = response.getOrElse(() => {});
      weathers.add(Weather.fromJson(jsonResponse));
      saveWeatherData(location, weathers);
      this.location = location;
    } else {
      responseState = response.fold((l) => l, (r) => ApiResponse.unknownError);
    }
    isLoading(false);
    update();
  }

  void saveWeatherData(String location, List<Weather> weathers) {
    box.write('location', location);
    List<Map<String, dynamic>> weatherList =
        weathers.map((weather) => weather.toJson()).toList();
    box.write('weathers', weatherList);
  }

  void searchLocation(String query) async {
    searchState(ApiResponse.loading);
    var response =
        await apiService.getRequst(endPoint: '&q=$query', isSearch: true);
    response.fold((left) {
      searchState.value = left;
    }, (right) {
      List<dynamic> jsonRes = right;
      if (jsonRes.isNotEmpty) {
        searchState(ApiResponse.ok);
        searchLocations.value = jsonRes
            .map(
                (json) => SearchLocation.fromJson(json as Map<String, dynamic>))
            .toList();
      }
    });
  }

  void selectLocation(String loc) async {
    await getWeatherData(loc);
    weathers.insert(0, weathers.last);
    weathers.removeLast();
    searchLocations.clear();
    searchState.value = ApiResponse.unknownError;
    updateBackgroundColor();
    Get.toNamed(AppRoutes.home);
    update();
  }

  Future<void> refreshWeather() async {
    final String name = weathers.first.location!.name!;
    final String region = weathers.first.location!.region!;
    await getWeatherData("$name $region");
    weathers.first = weathers.last;
    weathers.removeLast();
    updateBackgroundColor();
    update();
  }

  void onOutlookPageChange(index) {
    currentOutlookPage = index;
    update();
  }

  void updateBackgroundColor() {
    if (weathers.first.current!.isDay == 1) {
      backgroundColor = AppThemes.dayBackground;
    } else {
      backgroundColor = AppThemes.nightBackground;
    }
  }

  void autoRefresh() {
    if (settingsController.refreshTime.inHours != 0) {
      refreshWeather();
    }
  }

  void onReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) newIndex--;
    final Weather tempWeather = weathers.removeAt(oldIndex);
    weathers.insert(newIndex, tempWeather);
    refreshWeather();
    update();
  }

  @override
  void onInit() async {
    isLoading(true);
    location = box.read('location') ?? location;
    List<dynamic>? savedWeatherList = box.read<List<dynamic>>('weathers');
    if (savedWeatherList != null) {
      weathers.value =
          savedWeatherList.map((json) => Weather.fromJson(json)).toList();
    } else {
      await getWeatherData(location);
    }
    updateBackgroundColor();
    timer = Timer.periodic(settingsController.refreshTime, (t) => autoRefresh);
    isLoading(false);
    super.onInit();
  }
}
