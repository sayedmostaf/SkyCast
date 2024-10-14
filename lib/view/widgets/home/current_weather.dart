import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky_cast/controller/settings_controller.dart';
import 'package:sky_cast/core/themes/app_styles.dart';
import 'package:sky_cast/models/current_weather_model.dart';
import 'package:sky_cast/models/forecast_model.dart';

class CurrentWeather extends StatelessWidget {
  const CurrentWeather(
      {super.key,
      required this.current,
      required this.location,
      required this.day});
  final Current current;
  final Location location;
  final Day day;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
      builder: (controller) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${controller.unit == 'C' ? current.tempC!.toInt() : current.tempF!.toInt()}˚",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                SizedBox(
                  height: 150,
                  child: Text(
                    current.condition!.text!,
                    style: AppStyles.bodyMediumLarge,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    const Icon(Icons.location_pin),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text(
                        location.name!,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "${controller.unit == 'C' ? day.maxtempC!.toInt() : day.maxtempF!.toInt()}˚ / ${controller.unit == 'C' ? day.mintempC!.toInt() : day.mintempF!.toInt()}˚",
                    ),
                    const SizedBox(width: 7),
                    Text(
                      "Feels like ${controller.unit == 'C' ? current.feelslikeC!.toInt() : current.feelslikeF!.toInt()}˚",
                    ),
                  ],
                ),
              ],
            ),
          ),
          Image.network(
            "https:${current.condition!.icon}".replaceAll('64x64', '128x128'),
            scale: .7,
          ),
        ],
      ),
    );
  }
}
