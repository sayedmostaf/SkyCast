import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sky_cast/controller/weather_controller.dart';
import 'package:sky_cast/core/config/app_routes.dart';
import 'package:sky_cast/core/themes/app_styles.dart';
import 'package:sky_cast/models/current_weather_model.dart';
import 'package:sky_cast/models/weather.dart';
import 'package:sky_cast/util/helpers/app_helper.dart';
import 'package:sky_cast/view/widgets/drawer/drawer_location_widget.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key, required this.controller});
  final WeatherController controller;
  @override
  Widget build(BuildContext context) {
    final CurrentWeatherModel firstCurrentWeather =
        controller.weathers.first.currentWeatherModel;
    final RxList<Weather> weathers = controller.weathers;
    return Drawer(
      width: AppHelper.screenWidth(context) / 1.2,
      child: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 50,
        ),
        child: controller.isLoading.value
            ? Center(
                child: Lottie.asset('assets/lotties/loading.json'),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      iconSize: 30,
                      alignment: Alignment.topRight,
                      onPressed: () {
                        Get.back();
                        Get.toNamed(AppRoutes.settings);
                      },
                      icon: const Icon(Icons.settings),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  titleRow(Icons.star_rounded, 'Favourite location'),
                  const SizedBox(
                    height: 10,
                  ),
                  DrawerLocationWidget(
                    icon: Icons.location_pin,
                    location: firstCurrentWeather.location!.name!,
                    imageUrl: firstCurrentWeather.current!.condition!.icon,
                    temp:
                        firstCurrentWeather.current!.tempC!.toInt().toString(),
                    onTap: () {
                      Get.back();
                      Get.toNamed(AppRoutes.locations);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 10,
                  ),
                  titleRow(Icons.add_location, 'Other location'),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: controller.weathers.length,
                          itemBuilder: (context, index) => DrawerLocationWidget(
                              onTap: () {
                                Get.back();
                                Get.toNamed(AppRoutes.settings);
                              },
                              imageUrl: weathers[index]
                                  .currentWeatherModel
                                  .current!
                                  .condition!
                                  .icon,
                              location: weathers[index]
                                  .currentWeatherModel
                                  .location!
                                  .name!,
                              temp: weathers[index]
                                  .currentWeatherModel
                                  .current!
                                  .tempC!
                                  .toInt()
                                  .toString()))),
                  const SizedBox(
                    height: 30,
                  ),
                  MaterialButton(
                    onPressed: () {
                      Get.back();
                      Get.toNamed(AppRoutes.locations);
                    },
                    padding:
                        const EdgeInsets.symmetric(horizontal: 50, vertical: 7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: const Color(0xFF474646),
                    elevation: 0,
                    child: const Text(
                      'Manage locations',
                      style: AppStyles.bodyMediumLarge,
                    ),
                  ),
                ],
              ),
      )),
    );
  }

  titleRow(IconData icon, String title) {
    return Row(
      children: [
        Icon(
          icon,
          size: 25,
          color: Colors.grey,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          title,
          style: AppStyles.bodyMediumMed.copyWith(color: Colors.grey),
        ),
      ],
    );
  }
}
