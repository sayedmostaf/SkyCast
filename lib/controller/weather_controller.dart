import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
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
  final ApiService apiServices = ApiService();
  final LocationService locationServices = LocationService();
  final GetStorage box = GetStorage();
  String location = "Paris";
  RxBool isLoading = false.obs;
  int currOutlookPage = 0;
  late ApiResponse responseStatus;
  Rx<ApiResponse> searchStatus = ApiResponse.unknownError.obs;
  Color? backgroundColor;
  SettingsController settingsController = Get.find<SettingsController>();
  Timer? timer;
  RxList<Weather> weathers = <Weather>[].obs;
  RxList<SearchLocation> searchedLocations = <SearchLocation>[].obs;
  List<int> selectedLocations = <int>[];

  Future<void> getWeatherData(String query, {bool newLoc = false}) async {
    isLoading(true);
    var response = await apiServices.getRequst(endPoint: "&q=$query");

    if (response.isRight()) {
      //On Success
      responseStatus = ApiResponse.ok;
      Map<String, dynamic> jsonResponse = response.getOrElse(() => {});
      weathers.add(Weather.fromJson(jsonResponse));
      _updateWeathersList(newLoc: newLoc);
      saveWeatherData(query, weathers);
      location = query;
    } else {
      //On Error
      responseStatus = response.fold((l) => l, (r) => ApiResponse.unknownError);
      await _handelGetWeatherError(responseStatus);
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
    searchStatus(ApiResponse.loading);
    var response =
        await apiServices.getRequst(endPoint: "&q=$query", isSearch: true);
    response.fold((left) {
      //On Error
      searchStatus.value = left;
    }, (right) {
      //On Success
      List<dynamic> jsonRes = right;
      if (jsonRes.isNotEmpty) {
        searchStatus(ApiResponse.ok);
        searchedLocations.value = jsonRes
            .map(
              (json) => SearchLocation.fromJson(json as Map<String, dynamic>),
            )
            .toList();
      }
    });
  }

  void selectLocation(String loc) async {
    await getWeatherData(loc, newLoc: true);
    searchedLocations.clear();
    searchStatus.value = ApiResponse.unknownError;
    updateBackgrounColor();
    Get.toNamed(AppRoutes.home);
    update();
  }

  Future<void> getUserLocation() async {
    Either<LocationError, LocationData> result =
        await locationServices.getLocation();
    result.fold((left) async {
      _handelLocationError(left);
    }, (right) async {
      final String lat = right.latitude!.toString();
      final String lon = right.longitude!.toString();
      location = "$lat,$lon";
      await getWeatherData(location);
    });
  }

  Future<void> refreshWeather() async {
    final String favLoc =
        "${weathers.first.location!.name} ${weathers.first.location!.region}";
    await getWeatherData(favLoc);

    updateBackgrounColor();
    update();
  }

  void _updateWeathersList({bool newLoc = false}) {
    if (weathers.length > 1) {
      if (newLoc) {
        weathers.insert(0, weathers.last);
        weathers.removeLast();
      } else {
        weathers.first = weathers.last;
        weathers.removeLast();
      }
    }
  }

  void updateBackgrounColor() {
    if (weathers.first.current!.isDay == 1) {
      backgroundColor = AppThemes.dayBackground;
    } else {
      backgroundColor = AppThemes.nightBackground;
    }
  }

  void onReorder(int oldIndex, int newIndex) async {
    if (oldIndex < newIndex) newIndex--;
    final Weather tempWeather = weathers.removeAt(oldIndex);
    weathers.insert(newIndex, tempWeather);

    await refreshWeather();
  }

  /// Shows a Toast message for each [ApiResponse] error.
  Future<bool?> _handelGetWeatherError(ApiResponse error) {
    if (error == ApiResponse.offline) {
      return AppHelper.showToast("No network connection");
    } else if (error == ApiResponse.wrongLocation) {
      return AppHelper.showToast("Wrong location");
    } else if (error == ApiResponse.serverError) {
      return AppHelper.showToast("Server error, please try again");
    } else {
      return AppHelper.showToast("Unknown error occured.");
    }
  }

  /// Shows an AlertDialog for each [LocationError]
  _handelLocationError(LocationError error) async {
    getUserLocationCallBack() async {
      Get.back();
      await Future.delayed(const Duration(seconds: 2));
      await getUserLocation();
    }

    if (error == LocationError.offline) {
      await AppHelper.showOfflineDialog(
          cancelFunction: Get.back, confirmFunction: getUserLocationCallBack);
    } else if (error == LocationError.notEnabled) {
      await AppHelper.showNotEnabledDialog(
          cancelFunction: Get.back, confirmFunction: getUserLocationCallBack);
    } else if (error == LocationError.denied) {
      await AppHelper.showDeniedDialog(
          cancelFunction: Get.back, confirmFunction: getUserLocationCallBack);
    }
  }

  void _autoRefresh() async {
    if (settingsController.refreshTime.inHours != 0) {
      await refreshWeather();
    }
  }

  void onOutlookPageChange(index) {
    currOutlookPage = index;
    update();
  }

  onLongPressLocation(int index) {
    if (!selectedLocations.contains(index)) {
      selectedLocations.add(index);
    }
    update();
  }

  onTapLocation(int index) {
    if (selectedLocations.contains(index)) {
      selectedLocations.removeWhere((item) => item == index);
    }
    update();
  }

  /// Delete a location weather from [weathers] list.
  void deleteLocation() async {
    if (selectedLocations.isNotEmpty) {
      if (selectedLocations.contains(0)) {
        await AppHelper.showToast("Can't delete favourite location");
      } else {
        selectedLocations.forEach(weathers.removeAt);
        selectedLocations.clear();
        saveWeatherData(location, weathers);
        update();
      }
    } else {
      await AppHelper.showToast("Select location to delete");
    }
  }

  @override
  void onInit() async {
    isLoading(true);
    location = box.read<String>('location') ?? location;
    List<dynamic>? savedWeatherList = box.read<List<dynamic>>('weathers');
    if (savedWeatherList != null) {
      weathers.value =
          savedWeatherList.map((json) => Weather.fromJson(json)).toList();
    }
    await getUserLocation();
    updateBackgrounColor();
    // Start timer
    timer =
        Timer.periodic(settingsController.refreshTime, (t) => _autoRefresh());
    isLoading(false);
    super.onInit();
  }

  @override
  void onClose() async {
    await box.remove('weathers');
    weathers.clear();
    super.onClose();
  }
}
