import 'package:flutter/widgets.dart';
import 'package:sky_cast/core/themes/app_styles.dart';
import 'package:sky_cast/models/current_weather_model.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({super.key, required this.currentWeatherModel});
  final CurrentWeatherModel currentWeatherModel;

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
          Column(
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
                currentWeatherModel.location!.localtime!,
                style: AppStyles.bodyRegularSmall,
              ),
            ],
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
              Text("12˚ / 33˚"),
            ],
          )
        ],
      ),
    );
  }
}
