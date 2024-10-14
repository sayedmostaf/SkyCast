import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sky_cast/controller/weather_controller.dart';
import 'package:sky_cast/core/themes/app_styles.dart';
import 'package:sky_cast/models/current_weather_model.dart';
import 'package:sky_cast/util/helpers/app_helper.dart';
import 'package:sky_cast/view/widgets/drawer/drawer_location_widget.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key, required this.controller});
  final WeatherController controller;
  @override
  Widget build(BuildContext context) {
    final CurrentWeatherModel? currentWeatherModel = controller.currentWeather;
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
                        Get.toNamed('/settings');
                      },
                      icon: const Icon(Icons.settings),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        size: 25,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Favourite location',
                        style: AppStyles.bodyMediumMed
                            .copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DrawerLocationWidget(
                    icon: Icons.location_pin,
                    location: currentWeatherModel!.location!.name!,
                    imageUrl: currentWeatherModel.current!.condition!.icon,
                    temp:
                        currentWeatherModel.current!.tempC!.toInt().toString(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.add_location_alt_rounded,
                        size: 25,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Other locations',
                        style: AppStyles.bodyMediumLarge
                            .copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DrawerLocationWidget(
                    location: currentWeatherModel.location!.name!,
                    temp:
                        currentWeatherModel.current!.tempC!.toInt().toString(),
                    imageUrl: currentWeatherModel.current!.condition!.icon,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  MaterialButton(
                    onPressed: () {
                      Get.back();
                      Get.toNamed('/manage_location');
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
}
