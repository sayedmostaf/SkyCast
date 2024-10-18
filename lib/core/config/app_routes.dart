import 'package:get/get.dart';
import 'package:sky_cast/view/home_view.dart';
import 'package:sky_cast/view/locations_view.dart';
import 'package:sky_cast/view/search_view.dart';
import 'package:sky_cast/view/settings_view.dart';

class AppRoutes {
  static const String home = '/';
  static const String locations = '/locations';
  static const String settings = '/settings';
  static const String search = '/search';
  static List<GetPage> routes = [
    GetPage(
      name: home,
      page: () => const HomeView(),
    ),
    GetPage(
      name: locations,
      page: () => const LocationsView(),
    ),
    GetPage(
      name: settings,
      page: () => const SettingsView(),
    ),
    GetPage(
      name: search,
      page: () => const SearchView(),
    ),
  ];
}
