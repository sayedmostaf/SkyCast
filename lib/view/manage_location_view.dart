import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sky_cast/controller/weather_controller.dart';
import 'package:sky_cast/view/widgets/manage_locations/location_widget.dart';

class ManageLocationView extends StatelessWidget {
  ManageLocationView({super.key});
  final WeatherController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Locations'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: GetBuilder<WeatherController>(
              builder: (controller) => Column(
                    children: [
                      SearchBar(
                        padding: const WidgetStatePropertyAll(
                          EdgeInsets.symmetric(horizontal: 15),
                        ),
                        hintText: 'Search location..',
                        trailing: const [Icon(Icons.search)],
                        onSubmitted: (value) =>
                            controller.getWeatherData(value),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SingleChildScrollView(
                        child: Obx(
                          () => controller.isLoading.value == true
                              ? Lottie.asset('assets/lotties/loading.json')
                              : LocationWidget(
                                  currentWeatherModel:
                                      controller.currentWeather!,
                                  day: controller.forecastModel!.forecast!
                                      .forecastday!.first.day!,
                                ),
                        ),
                      )
                    ],
                  )),
        ),
      ),
    );
  }
}
