import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky_cast/core/themes/app_themes.dart';
import 'package:sky_cast/view/home_view.dart';
import 'package:sky_cast/view/manage_location_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => HomeView()),
        GetPage(name: '/manage_location', page: () => ManageLocationView()),
      ],
      theme: AppThemes.darkTheme,
    );
  }
}
