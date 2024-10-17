import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky_cast/controller/weather_controller.dart';
import 'package:sky_cast/core/themes/app_styles.dart';
import 'package:sky_cast/models/search_location.dart';

class SearchResultWidget extends StatelessWidget {
  const SearchResultWidget(
      {super.key, required this.controller, required this.searchedLocation});
  final WeatherController controller;
  final RxList<SearchLocation> searchedLocation;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 13,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF212121),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListView.builder(
        itemCount: searchedLocation.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) => InkWell(
          onTap: () => controller.selectLocation(
              "${searchedLocation[index].name} ${searchedLocation[index].region}"),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                searchedLocation[index].name!,
                style: AppStyles.bodySemiBoldLarge,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "${searchedLocation[index].region!} ${searchedLocation[index].country!}",
              ),
              if (index != searchedLocation.length - 1)
                const Divider(
                  height: 20,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
