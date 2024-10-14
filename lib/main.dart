import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sky_cast/core/themes/app_themes.dart';
import 'package:sky_cast/util/services/app_bindings.dart';
import 'package:sky_cast/view/home_view.dart';
import 'package:sky_cast/view/manage_location_view.dart';
import 'package:sky_cast/view/settings_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage().initStorage;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      initialBinding: AppBindings(),
      getPages: [
        GetPage(name: '/', page: () => const HomeView()),
        GetPage(name: '/manage_location', page: () => ManageLocationView()),
        GetPage(name: '/settings', page: () => const SettingsView()),
      ],
      theme: AppThemes.darkTheme,
    );
  }
}
