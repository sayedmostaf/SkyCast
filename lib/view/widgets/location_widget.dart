import 'package:flutter/widgets.dart';
import 'package:sky_cast/core/themes/app_styles.dart';
import 'package:sky_cast/models/current_weather_model.dart';
import 'package:sky_cast/models/forecast_model.dart';
import 'package:sky_cast/util/helpers/app_helper.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({
    super.key,
    required this.currentWeatherModel,
    required this.day,
  });
  final CurrentWeatherModel currentWeatherModel;
  final Day day;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xC919346B),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentWeatherModel.location!.name!,
                  style: AppStyles.bodySemiBoldLarge,
                ),
                Text(
                  currentWeatherModel.location!.country!,
                  style: AppStyles.bodyRegularSmall,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '${AppHelper.getHumanReadableData(currentWeatherModel.location!.localtime!.split(' ').first)}, ${AppHelper.getHumanReadableData(currentWeatherModel.location!.localtime!.split(' ').last)}',
                  style: AppStyles.bodyRegularSmall,
                ),
              ],
            ),
          ),
          const Spacer(),
          Image.network(
              "https:${currentWeatherModel.current!.condition!.icon}"),
          const SizedBox(
            width: 10,
          ),
          Column(
            children: [
              Text(
                "${currentWeatherModel.current!.tempC!.toInt()}˚",
                style: AppStyles.bodyRegularVeryLarge,
              ),
              Text("${day.maxtempC!.toInt()}˚ / ${day.mintempC!.toInt()}˚"),
            ],
          )
        ],
      ),
    );
  }
}
