import 'package:get/get.dart';
import 'package:sky_cast/view/home_view.dart';
import 'package:sky_cast/view/manage_location_view.dart';
import 'package:sky_cast/view/settings_view.dart';

class AppRoutes {
  static const String home = '/';
  static const String locations = '/locations';
  static const String settings = '/settings';
  static List<GetPage> routes = [
    GetPage(
      name: home,
      page: () => const HomeView(),
    ),
    GetPage(
      name: locations,
      page: () => ManageLocationView(),
    ),
    GetPage(
      name: settings,
      page: () => const SettingsView(),
    ),
  ];
}
