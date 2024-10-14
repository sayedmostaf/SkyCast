import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sky_cast/controller/weather_controller.dart';
import 'package:sky_cast/core/config/app_routes.dart';
import 'package:sky_cast/view/widgets/manage_locations/location_widget.dart';

class LocationsView extends StatelessWidget {
  LocationsView({super.key});
  final WeatherController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Locations'),
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(AppRoutes.search),
            icon: const Icon(
              Icons.add_outlined,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.delete_outlined,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: GetBuilder<WeatherController>(
              builder: (controller) => Column(
                    children: [
                      Obx(
                        () => controller.weathers.isEmpty
                            ? Lottie.asset('assets/lotties/loading.json')
                            : Expanded(
                                child: ReorderableListView.builder(
                                  itemBuilder: (context, index) =>
                                      LocationWidget(
                                    key: Key(index.toString()),
                                    currentWeatherModel:
                                        controller.currentWeather!,
                                    day: controller.forecastModel!.forecast!
                                        .forecastday!.first.day!,
                                  ),
                                  itemCount: controller.weathers.length,
                                  onReorder: (oldIndex, newIndex) =>
                                      controller.onReorder(oldIndex, newIndex),
                                ),
                              ),
                      ),
                    ],
                  )),
        ),
      ),
    );
  }
}
