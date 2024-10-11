import 'package:flutter/material.dart';
import 'package:sky_cast/core/themes/app_styles.dart';

class CurrentWeather extends StatelessWidget {
  const CurrentWeather({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '25',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            Text(
              'rain',
              style: AppStyles.bodyMediumLarge,
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                const Icon(Icons.location_pin),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  'Texas City',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          const SizedBox(
              height: 10,
            ),
            Text('40˚ / 27˚ Feels like 28˚'),
          ],
        ),
      ],
    );
  }
}
