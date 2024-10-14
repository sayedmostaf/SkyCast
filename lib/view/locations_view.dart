import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sky_cast/controller/weather_controller.dart';
import 'package:sky_cast/core/config/app_routes.dart';
import 'package:sky_cast/core/themes/app_styles.dart';
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
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: GetBuilder<WeatherController>(
              builder: (controller) => Column(
                    children: [
                      Obx(
                        () => controller.weathers.isEmpty
                            ? Lottie.asset('assets/lotties/loading.json')
                            : Expanded(
                                child: ReorderableListView.builder(
                                  itemBuilder: (context, index) => Column(
                                    key: Key("$index+Col"),
                                    children: [
                                      if (index == 1)
                                        GestureDetector(
                                          onLongPress: () {},
                                          child: titleRow(
                                              ValueKey("$index+title"),
                                              Icons.add_location,
                                              'Ohter locations'),
                                        ),
                                      LocationWidget(
                                        key: Key(index.toString()),
                                        currentWeatherModel: controller
                                            .weathers[index]
                                            .currentWeatherModel,
                                        day: controller
                                            .weathers[index]
                                            .forecastModel
                                            .forecast!
                                            .forecastday!
                                            .first
                                            .day!,
                                      ),
                                      SizedBox(
                                        height: 10,
                                        key: Key('$index+SizedBox'),
                                      ),
                                    ],
                                  ),
                                  itemCount: controller.weathers.length,
                                  onReorder: (oldIndex, newIndex) =>
                                      controller.onReorder(oldIndex, newIndex),
                                  header: titleRow(null, Icons.star_rounded,
                                      'Favourite location'),
                                ),
                              ),
                      
                      ),
                    ],
                  )),
        ),
      ),
    );
  }

  titleRow(Key? key, IconData icon, String title) {
    return Row(
      key: key,
      children: [
        Icon(
          icon,
          size: 25,
          color: Colors.grey,
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: AppStyles.bodyMediumMed.copyWith(color: Colors.grey),
        ),
        const SizedBox(height: 40)
      ],
    );
  }
}
