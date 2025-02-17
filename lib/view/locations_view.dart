import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sky_cast/controller/weather_controller.dart';
import 'package:sky_cast/core/config/app_routes.dart';
import 'package:sky_cast/view/widgets/manage_locations/location_widget.dart';
import 'package:sky_cast/view/widgets/manage_locations/title_row.dart';

class LocationsView extends StatelessWidget {
  const LocationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WeatherController>(
      builder: (controller) => Scaffold(
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
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
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
                                    child: const TitleRow(
                                      icon: Icons.add_location,
                                      title: 'Ohter locations',
                                    ),
                                  ),
                                LocationWidget(
                                  key: Key(index.toString()),
                                  weather: controller.weathers[index],
                                  day: controller.weathers[index].forecast!
                                      .forecastday!.first.day!,
                                  index: index,
                                  isSelected: controller.selectedLocations
                                      .contains(index),
                                  onTap: () => controller.onTapLocation(index),
                                  onLongPress: () =>
                                      controller.onLongPressLocation(index),
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
                            header: const TitleRow(
                              icon: Icons.star_rounded,
                              title: 'Favourite location',
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: controller.deleteLocation,
          child: const Icon(Icons.delete),
        ),
      ),
    );
  }
}
