import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky_cast/controller/weather_controller.dart';
import 'package:sky_cast/core/themes/app_styles.dart';
import 'package:sky_cast/view/widgets/current_weather.dart';
import 'package:sky_cast/view/widgets/custom_darwer.dart';
import 'package:sky_cast/view/widgets/daily_forecast.dart';
import 'package:sky_cast/view/widgets/hourly_forecast.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final WeatherController controller = Get.put(WeatherController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: CustomDarwer(
        controller: controller,
      ),
      body: GetBuilder<WeatherController>(
        builder: ((controller) => RefreshIndicator(
              onRefresh: () => controller.getCurrentWeather('cairo'),
              child: SafeArea(
                  child: controller.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                controller.weather == null
                                    ? const Text("No weather data")
                                    : CurrentWeather(
                                        currentWeatherModel:
                                            controller.weather!,
                                      ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(13),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: const Color(0xC919346B),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'A few clouds. Low 27C.',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Divider(
                                        thickness: .2,
                                        color: Color(0xFF9495B8),
                                      ),
                                      HourlyForecast(),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(13),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: const Color(0xC919346B),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: const Column(
                                    children: [
                                      Text(
                                        "Don't miss the sunset",
                                        style: AppStyles.bodyMediumLarge,
                                      ),
                                      Text('Sunset will be at 7:54'),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                DailyForecast(),
                              ],
                            ),
                          ),
                        )),
            )),
      ),
    );
  }
}
