import 'package:flutter/material.dart';
import 'package:sky_cast/core/themes/app_styles.dart';
import 'package:sky_cast/models/forecast_model.dart';

class HourlyForecast extends StatelessWidget {
  const HourlyForecast({super.key, required this.day, required this.hours});
  final Day day;
  final List<Hour> hours;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xC919346B),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${day.condition!.text}. Low of ${day.mintempC!.toInt()}C˚.",
            style: AppStyles.bodySemiBoldMed,
          ),
          const Divider(
            thickness: 0.2,
            color: Color(0xFF9495B8),
          ),
          SizedBox(
            height: 120,
            child: ListView.builder(
                itemCount: 24,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Row(
                      children: [
                        Column(
                          children: [
                            Text(hours[index].time!.substring(11, 13)),
                            const SizedBox(
                              height: 10,
                            ),
                            Icon(
                              hours[index].isDay == 1
                                  ? Icons.wb_sunny
                                  : Icons.nightlight_round_sharp,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text("${hours[index].tempC!.toInt()}˚"),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.water_drop_sharp,
                                  size: 15,
                                  color: Color(0xFF637BA7),
                                ),
                                Text(
                                  "${hours[index].chanceOfRain}%",
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    )),
          ),
        ],
      ),
    );
  }
}
