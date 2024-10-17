import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AppHelper {
  static SnackbarController showSnackbar(
      {required String title, required String message, bool isError = true}) {
    return Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      isDismissible: true,
      backgroundColor: isError ? Colors.red[400] : Colors.green,
      colorText: Colors.white,
    );
  }

  // static String getHumanReadableData(String date) {
  //   DateTime inputDate = DateTime.parse(date);
  //   DateTime now = DateTime.now();
  //   DateTime today = DateTime(now.year, now.month, now.day);
  //   DateTime yesterday = today.subtract(const Duration(days: 1));
  //   if (inputDate == today) {
  //     return 'Today';
  //   } else if (inputDate == yesterday) {
  //     return 'Yesterday';
  //   } else {
  //     return DateFormat('EEEE').format(inputDate); // day of week
  //   }
  // }
  static String getHumanReadableData(String date) {
    try {
      DateTime inputDate = DateTime.parse(date);
      DateTime now = DateTime.now();
      DateTime today = DateTime(now.year, now.month, now.day);
      DateTime yesterday = today.subtract(const Duration(days: 1));

      if (inputDate.isAtSameMomentAs(today)) {
        return 'Today';
      } else if (inputDate.isAtSameMomentAs(yesterday)) {
        return 'Yesterday';
      } else {
        return DateFormat('EEEE').format(inputDate); // day of week
      }
    } catch (e) {
      return 'Invalid date';
    }
  }

  static String getUVIndexDescription(double uvIndex) {
    if (uvIndex <= 2) {
      return 'Low';
    } else if (uvIndex <= 5) {
      return 'Moderate';
    } else if (uvIndex <= 7) {
      return 'High';
    } else if (uvIndex <= 10) {
      return 'Very High';
    } else {
      return 'Extreme';
    }
  }

  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static Future<bool> checkInternet() async {
    try {
      var result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
}
