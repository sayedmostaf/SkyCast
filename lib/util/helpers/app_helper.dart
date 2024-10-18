import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sky_cast/core/themes/app_styles.dart';
import 'package:fluttertoast/fluttertoast.dart';


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

  static Future showDialog(
      {required String title,
      required String message,
      required String cancelButtonText,
      required String confirmButtonText,
      required void Function()? onPressCancel,
      required void Function()? onPressConfirm}) async {
    return await Get.dialog(
      AlertDialog(
        title: Text(title),
        titleTextStyle: AppStyles.bodyMediumLarge,
        content: Text(message),
        contentTextStyle:
            AppStyles.bodyRegularLarge.copyWith(color: Colors.grey[400]),
        actions: [
          MaterialButton(
              onPressed: onPressCancel, child: Text(cancelButtonText)),
          MaterialButton(
            onPressed: onPressConfirm,
            color: Colors.blue.shade700,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Text(confirmButtonText),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  static Future showOfflineDialog(
      {required void Function()? cancelFunction,
      required void Function()? confirmFunction}) {
    return AppHelper.showDialog(
      title: "No Internet connection",
      message: "Make sure you have stable internet connection and try again.",
      cancelButtonText: "Discard",
      confirmButtonText: "Try again",
      onPressCancel: cancelFunction,
      onPressConfirm: confirmFunction,
    );
  }

  static Future showNotEnabledDialog(
      {required void Function()? cancelFunction,
      required void Function()? confirmFunction}) {
    return AppHelper.showDialog(
      title: "Location services not enabled",
      message:
          "Make sure to enable location service on your phone and try again.",
      cancelButtonText: "Discard",
      confirmButtonText: "Try again",
      onPressCancel: cancelFunction,
      onPressConfirm: confirmFunction,
    );
  }

  static Future showDeniedDialog(
      {required void Function()? cancelFunction,
      required void Function()? confirmFunction}) {
    return AppHelper.showDialog(
      title: "Location services denied",
      message:
          "Make sure to allow location access for this app from app settings.",
      cancelButtonText: "Discard",
      confirmButtonText: "Allow",
      onPressCancel: cancelFunction,
      onPressConfirm: confirmFunction,
    );
  }
  

  static Future<void> showToast(String message) {
    return Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.black87,
    );
  }
}
