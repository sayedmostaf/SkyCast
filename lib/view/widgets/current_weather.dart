import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky_cast/core/themes/app_styles.dart';
import 'package:sky_cast/models/current_weather_model.dart';

class CurrentWeather extends StatelessWidget {
  const CurrentWeather({super.key, required this.currentWeatherModel});
  final CurrentWeatherModel currentWeatherModel;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${currentWeatherModel.current!.tempC!.toInt().toString()}˚',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            Text(
              currentWeatherModel.current!.condition!.text!,
              style: AppStyles.bodyMediumLarge,
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
                Text(
                  currentWeatherModel.location!.name!,
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
                '40˚ / 27˚ Feels like ${currentWeatherModel.current!.feelslikeC!.toInt().toString()}˚'),
          ],
        ),
        Image.network(
          "https:${currentWeatherModel.current!.condition!.icon}"
              .replaceAll('64x64', '128x128'),
          scale: .7,
        ),
      ],
    );
  }
}
