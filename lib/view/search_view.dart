import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sky_cast/controller/weather_controller.dart';
import 'package:sky_cast/core/themes/app_styles.dart';
import 'package:sky_cast/models/enums.dart';
import 'package:sky_cast/view/widgets/search/search_result_widget.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search location'),
      ),
      body: GetBuilder<WeatherController>(
        builder: (controller) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SearchBar(
                    autoFocus: true,
                    padding: const WidgetStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 15),
                    ),
                    elevation: const WidgetStatePropertyAll(1),
                    hintText: 'Search location..',
                    trailing: const [Icon(Icons.search)],
                    onChanged: (value) => controller.searchLocation(value),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(() {
                    if (controller.searchState.value == ApiResponse.ok) {
                      return SearchResultWidget(
                        controller: controller,
                        searchedLocation: controller.searchLocations,
                      );
                    } else if (controller.searchState.value ==
                        ApiResponse.offline) {
                      return Column(
                        children: [
                          Lottie.asset('assets/lotties/offline.json'),
                          Text(
                            'No internet connection!',
                            style: AppStyles.bodyRegularVeryLarge
                                .copyWith(color: Colors.grey),
                          ),
                        ],
                      );
                    } else if (controller.searchState.value ==
                        ApiResponse.loading) {
                      return Column(
                        children: [
                          Lottie.asset('assets/lotties/loading.json'),
                          Text(
                            'Loading...',
                            style: AppStyles.bodyRegularVeryLarge
                                .copyWith(color: Colors.grey),
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          Lottie.asset('assets/lotties/search.json'),
                          Text(
                            'Enter a location name',
                            style: AppStyles.bodyRegularVeryLarge
                                .copyWith(color: Colors.grey),
                          ),
                        ],
                      );
                    }
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
