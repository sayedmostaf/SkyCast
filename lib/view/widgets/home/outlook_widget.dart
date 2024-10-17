import 'package:flutter/material.dart';
import 'package:sky_cast/controller/weather_controller.dart';
import 'package:sky_cast/core/themes/app_styles.dart';
import 'package:sky_cast/models/weather.dart';

class OutlookWidget extends StatelessWidget {
  const OutlookWidget(
      {super.key, required this.astro, required this.controller});
  final Astro astro;
  final WeatherController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(13),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xC919346B),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 50,
            child: PageView.builder(
                itemCount: astroInfo(astro: astro).length,
                controller: controller.outlookPageController,
                onPageChanged: (index) => controller.onOutlookPageChange(index),
                itemBuilder: (context, index) =>
                    astroInfo(astro: astro)[index]),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(
                astroInfo(astro: astro).length,
                (index) => AnimatedContainer(
                  curve: Easing.emphasizedDecelerate,
                  duration: const Duration(milliseconds: 500),
                  width: 7,
                  height: 7,
                  margin: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: controller.currentOutlookPage == index
                        ? Colors.white
                        : Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

List<Column> astroInfo({required Astro astro}) {
  return <Column>[
    Column(
      children: [
        const Text(
          'Don\'t miss the sunset',
          style: AppStyles.bodyMediumLarge,
        ),
        Text("Sunset will be at ${astro.sunset}"),
      ],
    ),
    Column(
      children: [
        const Text(
          'Don\'t miss the sunrise',
          style: AppStyles.bodyMediumLarge,
        ),
        Text("Sunrise will be at ${astro.sunrise}"),
      ],
    ),
    Column(
      children: [
        const Text(
          'Don\'t miss the moonrise',
          style: AppStyles.bodyMediumLarge,
        ),
        Text("Sunrise will be at ${astro.moonrise}"),
      ],
    ),
  ];
}
