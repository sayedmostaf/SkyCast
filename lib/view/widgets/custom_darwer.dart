import 'package:flutter/material.dart';
import 'package:sky_cast/core/themes/app_styles.dart';

class CustomDarwer extends StatelessWidget {
  const CustomDarwer({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.star_rounded,
                  size: 25,
                  color: Colors.grey,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Favourite location',
                  style: AppStyles.bodyMediumMed.copyWith(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            drawerLocation(
              icon: Icons.location_pin,
              location: 'cairo',
              isDay: 1,
              temp: '50',
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Icon(
                  Icons.add_location_alt_rounded,
                  size: 25,
                  color: Colors.grey,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Other locations',
                  style: AppStyles.bodyMediumLarge.copyWith(color: Colors.grey),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}

Widget drawerLocation(
    {IconData? icon,
    required String location,
    int? isDay,
    required String temp}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Row(
      children: [
        Icon(icon),
        const SizedBox(
          width: 10,
        ),
        Text(
          location,
          style: AppStyles.bodyMediumLarge,
        ),
        const Spacer(),
        if (isDay != null)
          isDay == 1
              ? const Icon(
                  Icons.sunny,
                  size: 20,
                )
              : const Icon(
                  Icons.nightlife,
                  size: 20,
                ),
        Text(temp),
      ],
    ),
  );
}
