import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sky_cast/core/themes/app_styles.dart';

class PropertyWidget extends StatelessWidget {
  const PropertyWidget(
      {super.key,
      required this.name,
      required this.value,
      required this.photo});
  final String name, value, photo;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 25),
        decoration: BoxDecoration(
          color: const Color(0xC919346B),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Column(
            children: [
              SvgPicture.asset(
                "assets/svg/$photo",
                width: 40,
                height: 40,
                allowDrawingOutsideViewBox: true,
              ),
              Text(
                name,
                style: AppStyles.bodyBoldMed,
              ),
              Text(
                value,
                style: const TextStyle(
                  color: Color(0xFFBCBCBC),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
