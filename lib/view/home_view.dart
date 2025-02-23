import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sky_cast/controller/weather_controller.dart';
import 'package:sky_cast/util/helpers/app_helper.dart';
import 'package:sky_cast/view/custom_drawer.dart';
import 'package:sky_cast/view/widgets/home/current_weather.dart';
import 'package:sky_cast/view/widgets/home/daily_forecast.dart';
import 'package:sky_cast/view/widgets/home/double_property_widget.dart';
import 'package:sky_cast/view/widgets/home/hourly_forecast.dart';
import 'package:sky_cast/view/widgets/home/outlook_widget.dart';
import 'package:sky_cast/view/widgets/home/property_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WeatherController>(
      init: WeatherController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(),
        drawer: CustomDrawer(
          controller: controller,
        ),
        body: GetBuilder<WeatherController>(
          builder: ((controller) => RefreshIndicator(
                child: SafeArea(
                    child: controller.isLoading.value
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
                                    location:
                                        controller.weathers.first.location!,
                                    current: controller.weathers.first.current!,
                                    day: controller.weathers.first.forecast!
                                        .forecastday!.first.day!,
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  HourlyForecast(
                                    day: controller.weathers.first.forecast!
                                        .forecastday!.first.day!,
                                    hours: controller.weathers.first.forecast!
                                        .forecastday!.first.hour!,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  OutlookWidget(
                                    controller: controller,
                                    astro: controller.weathers.first.forecast!
                                        .forecastday!.first.astro!,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  DailyForecast(
                                    forecastday: controller
                                        .weathers.first.forecast!.forecastday!,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      PropertyWidget(
                                        name: 'UV index',
                                        value: AppHelper.getUVIndexDescription(
                                          controller
                                              .weathers.first.current!.uv!,
                                        ),
                                        photo: 'uv.svg',
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      PropertyWidget(
                                        name: 'Humidity',
                                        value:
                                            "${controller.weathers.first.current!.humidity}%",
                                        photo: 'water.svg',
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      PropertyWidget(
                                        name: 'Wind',
                                        value:
                                            "${controller.weathers.first.current!.windKph!.toInt()} km/h",
                                        photo: 'wind.svg',
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      DoublePropertyWidget(
                                        photo1: 'sunrise.svg',
                                        photo2: 'sunset.svg',
                                        name1: 'Sunrise',
                                        name2: 'Sunset',
                                        value1: controller
                                            .weathers
                                            .first
                                            .forecast!
                                            .forecastday!
                                            .first
                                            .astro!
                                            .sunrise!,
                                        value2: controller
                                            .weathers
                                            .first
                                            .forecast!
                                            .forecastday!
                                            .first
                                            .astro!
                                            .sunset!,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )),
                onRefresh: () => controller.refreshWeather(),
              )),
        ),
      ),
    );
  }
}
