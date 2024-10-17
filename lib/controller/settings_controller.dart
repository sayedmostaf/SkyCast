import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsController extends GetxController {
  bool isDarkMode = true;
  GetStorage box = GetStorage();
  String unit = 'C';
  Duration refreshTime = const Duration(hours: 1);

  void setUnit(String unit) {
    this.unit = unit;
    box.write('unit', unit);
    update();
  }

  void setRefreshTime(int hours) {
    refreshTime = Duration(hours: hours);
    box.write('refreshTime', hours);
    update();
  }

  void switchTheme(bool value) {
    isDarkMode = value;
    if (!value) {
      Get.changeThemeMode(ThemeMode.dark);
    } else {
      Get.changeThemeMode(ThemeMode.light);
    }
    box.write('isDarkMode', isDarkMode);
    update();
  }

  void updateDate() {
    unit = box.read('unit') ?? unit;
    int? storedHours = box.read('refreshTime');
    refreshTime =
        storedHours != null ? Duration(hours: storedHours) : refreshTime;
  }

  @override
  void onInit() {
    updateDate();
    super.onInit();
  }
}
