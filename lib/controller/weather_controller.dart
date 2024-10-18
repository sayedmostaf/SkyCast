import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:location/location.dart';
import 'package:sky_cast/controller/settings_controller.dart';
import 'package:sky_cast/core/config/app_routes.dart';
import 'package:sky_cast/core/themes/app_themes.dart';
import 'package:sky_cast/models/enums.dart';
import 'package:sky_cast/models/search_location.dart';
import 'package:sky_cast/models/weather.dart';
import 'package:sky_cast/util/helpers/app_helper.dart';
import 'package:sky_cast/util/services/api_service.dart';
import 'package:sky_cast/util/services/location_service.dart';

class WeatherController extends GetxController {
  final ApiService apiService = ApiService();
  final LocationService locationServices = LocationService();
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
  int refreshCounter = 0;

  Future<void> getWeatherData(String query, {bool newLocation = false}) async {
    isLoading(true);
    var response = await apiService.getRequst(endPoint: '&q=$query');

    if (response.isRight()) {
      responseState = ApiResponse.ok;
      Map<String, dynamic> jsonResponse = response.getOrElse(() => {});
      weathers.add(Weather.fromJson(jsonResponse));
      updateWeathersList(newLocation: newLocation);
      saveWeatherData(query, weathers);
      location = query;
    } else {
      responseState = response.fold((l) => l, (r) => ApiResponse.unknownError);
      if (responseState == ApiResponse.offline) {
        await AppHelper.showOfflineDialog(
            cancelFunction: Get.back,
            confirmFunction: () async {
              Get.back();
              await Future.delayed(const Duration(seconds: 2));
              await getWeatherData(query);
            });
      }
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
    await getWeatherData(loc, newLocation: true);
    searchLocations.clear();
    searchState.value = ApiResponse.unknownError;
    updateBackgroundColor();
    Get.toNamed(AppRoutes.home);
    update();
  }

  Future<void> getUserLocation() async {
    Either<LocationError, LocationData> result =
        await locationServices.getLocation();

    result.fold((left) async {
      handelLocationError(left);
    }, (right) async {
      final String lon = right.longitude.toString();
      final String lat = right.latitude.toString();
      location = '$lat,$lon';
      await getWeatherData(location);
    });
  }

  Future<void> refreshWeather() async {
    if (refreshCounter < 3) {
      await getWeatherData(location);
      refreshCounter++;
    } else {
      await getUserLocation();
      refreshCounter = 0;
    }
    updateBackgroundColor();
    update();
  }

  void updateWeathersList({bool newLocation = false}) {
    if (newLocation) {
      if (weathers.length > 1) {
        weathers.insert(0, weathers.last);
        weathers.removeLast();
      }
    } else {
      if (weathers.length > 1) {
        weathers.first = weathers.last;
        weathers.removeLast();
      }
    }
  }

  handelLocationError(LocationError error) async {
    getWeatherCallBack() async {
      Get.back();
      await Future.delayed(const Duration(seconds: 2));
      await getUserLocation();
    }

    if (error == LocationError.offline) {
      await AppHelper.showOfflineDialog(
          cancelFunction: Get.back, confirmFunction: getWeatherCallBack);
    } else if (error == LocationError.denied) {
      await AppHelper.showDeniedDialog(
          cancelFunction: Get.back, confirmFunction: getWeatherCallBack);
    } else if (error == LocationError.notEnabled) {
      await AppHelper.showNotEnabledDialog(
          cancelFunction: Get.back, confirmFunction: getWeatherCallBack);
    }
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
    location = box.read<String>('location') ?? location;
    List<dynamic>? savedWeatherList = box.read<List<dynamic>>('weathers');
    if (savedWeatherList != null) {
      weathers.value =
          savedWeatherList.map((json) => Weather.fromJson(json)).toList();
    } else {
      await getUserLocation();
    }
    timer = Timer.periodic(settingsController.refreshTime, (t) => autoRefresh);
    isLoading(false);
    super.onInit();
  }

  @override
  void onClose() async {
    await box.remove('weathers');
    weathers.clear();
    outlookPageController.dispose();
    super.onClose();
  }
}
