import 'package:flutter/widgets.dart';
import 'package:sky_cast/core/themes/app_styles.dart';

class OutlookWidget extends StatelessWidget {
  const OutlookWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(13),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xC919346B),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Column(
        children: [
          Text(
            "Don't miss the sunset",
            style: AppStyles.bodyMediumLarge,
          ),
          Text("Sunset will be at 7:54"),
        ],
      ),
    );
  }
}
