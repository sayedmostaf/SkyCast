import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sky_cast/controller/weather_controller.dart';
import 'package:sky_cast/view/widgets/current_weather.dart';
import 'package:sky_cast/view/widgets/custom_darwer.dart';
import 'package:sky_cast/view/widgets/daily_forecast.dart';
import 'package:sky_cast/view/widgets/hourly_forecast.dart';
import 'package:sky_cast/view/widgets/outlook_widget.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final WeatherController controller = Get.put(WeatherController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: CustomDarwer(
        controller: controller,
        currentWeatherModel: controller.currentWeather,
      ),
      body: GetBuilder<WeatherController>(
        builder: ((controller) => RefreshIndicator(
            child: SafeArea(
                child: controller.currentWeather == null &&
                        controller.forecastModel == null
                    ? Center(
                        child: Lottie.asset('assets/lotties/loading.json'),
                      )
                    : SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              CurrentWeather(
                                currentWeatherModel: controller.currentWeather!,
                                day: controller.forecastModel!.forecast!
                                    .forecastday!.first.day!,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              controller.forecastModel!.forecast == null
                                  ? Text('No day data')
                                  : HourlyForecast(
                                      day: controller.forecastModel!.forecast!
                                          .forecastday!.first.day!,
                                      hours: controller.forecastModel!.forecast!
                                          .forecastday!.first.hour!,
                                    ),
                              const SizedBox(
                                height: 10,
                              ),
                              const OutlookWidget(),
                              const SizedBox(
                                height: 10,
                              ),
                              DailyForecast(),
                            ],
                          ),
                        ),
                      )),
            onRefresh: () => controller.getCurrentWeather('paris'))),
      ),
    );
  }
}
