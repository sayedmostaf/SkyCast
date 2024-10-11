import 'package:flutter/material.dart';

class HourlyForecast extends StatelessWidget {
  const HourlyForecast({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: ListView.builder(
        itemCount: 12,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => const Row(
          children: [
            Column(
              children: [
                Text('01:00'),
                SizedBox(
                  height: 10,
                ),
                Icon(Icons.nightlight_round_sharp),
                SizedBox(
                  height: 10,
                ),
                Text('31˚'),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.water_drop_sharp,
                      size: 15,
                    ),
                    Text('0%'),
                  ],
                ),
              ],
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}
