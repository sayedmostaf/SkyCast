import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky_cast/controller/settings_controller.dart';
import 'package:sky_cast/core/themes/app_styles.dart';
import 'package:sky_cast/models/weather.dart';
import 'package:sky_cast/util/helpers/app_helper.dart';

class DailyForecast extends StatelessWidget {
  const DailyForecast({super.key, required this.forecastday});
  final List<Forecastday> forecastday;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
      builder: (controller) => Container(
        
        padding: const EdgeInsets.all(13),
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xC919346B),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: forecastday.length,
          itemBuilder: (context, index) => Column(
            mainAxisSize: MainAxisSize.min,
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
                    '${controller.unit == 'C' ? forecastday[index].day!.maxtempC!.toInt() : forecastday[index].day!.maxtempF!.toInt()}',
                    style: AppStyles.bodyMediumLarge,
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  Text(
                    '${controller.unit == 'C' ? forecastday[index].day!.mintempC!.toInt() : forecastday[index].day!.mintempF!.toInt()}',
                    style: AppStyles.bodyMediumLarge,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
