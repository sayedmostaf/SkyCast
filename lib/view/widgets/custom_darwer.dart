import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sky_cast/controller/weather_controller.dart';
import 'package:sky_cast/core/themes/app_styles.dart';
import 'package:sky_cast/models/current_weather_model.dart';

class CustomDarwer extends StatelessWidget {
  const CustomDarwer(
      {super.key, required this.controller, this.currentWeatherModel});
  final WeatherController controller;
  final CurrentWeatherModel? currentWeatherModel;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 50,
        ),
        child: currentWeatherModel == null
            ? Center(
                child: Lottie.asset('assets/lotties/loading.json'),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                  drawerLocation(
                    icon: Icons.location_pin,
                    location: currentWeatherModel!.location!.name!,
                    imageUrl: currentWeatherModel!.current!.condition!.icon,
                    temp:
                        currentWeatherModel!.current!.tempC!.toInt().toString(),
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
                  drawerLocation(
                    location: currentWeatherModel!.location!.name!,
                    temp:
                        currentWeatherModel!.current!.tempC!.toInt().toString(),
                    imageUrl: currentWeatherModel!.current!.condition!.icon,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  MaterialButton(
                    onPressed: () => Get.toNamed('/manage_location'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
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

Widget drawerLocation({
  IconData? icon,
  required String location,
  String? imageUrl,
  required String temp,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Row(
      children: [
        Icon(icon),
        const SizedBox(
          width: 10,
        ),
        Text(
          location,
          style: AppStyles.bodyMediumLarge,
        ),
        const Spacer(),
        if (imageUrl != null)
          Image.network(
            "https:$imageUrl",
            scale: 2,
          ),
        const SizedBox(
          width: 10,
        ),
        Text(temp),
      ],
    ),
  );
}
