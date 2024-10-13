import 'package:flutter/material.dart';
import 'package:sky_cast/core/themes/app_styles.dart';
import 'package:sky_cast/models/forecast_model.dart';
import 'package:sky_cast/util/helpers/app_helper.dart';

class DailyForecast extends StatelessWidget {
  const DailyForecast({super.key, required this.forecastday});
  final List<Forecastday> forecastday;
  @override
  Widget build(BuildContext context) {
    print("forecast: ${forecastday.length}");
    return Container(
      height: 230,
      padding: const EdgeInsets.all(13),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xC919346B),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListView.builder(
        itemCount: forecastday.length,
        itemBuilder: (context, index) => Column(
          children: [
            Row(
              children: [
                Text(
                  AppHelper.getHumanReadableData(forecastday[index].date!),
                  style: AppStyles.bodyMediumLarge,
                ),
                const Spacer(),
                const Icon(
                  Icons.water_drop,
                  size: 15,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text('${forecastday[index].day!.dailyChanceOfRain}%'),
                const SizedBox(
                  width: 40,
                ),
                Text(
                  '${forecastday[index].day!.maxtempC!.toInt()}˚ ${forecastday[index].day!.mintempC!.toInt()}˚',
                  style: AppStyles.bodyMediumLarge,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
