import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sky_cast/core/themes/app_styles.dart';

class DoublePropertyWidget extends StatelessWidget {
  const DoublePropertyWidget(
      {super.key,
      required this.photo1,
      required this.photo2,
      required this.name1,
      required this.name2,
      required this.value1,
      required this.value2});
  final String photo1, photo2;
  final String name1, name2;
  final String value1, value2;

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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  SvgPicture.asset(
                    'assets/svg/$photo1',
                    width: 40,
                    height: 40,
                    allowDrawingOutsideViewBox: true,
                  ),
                  Text(
                    name1,
                    style: AppStyles.bodyBoldMed,
                  ),
                  Text(
                    value1,
                    style: const TextStyle(
                      color: Color(0xFFBCBCBC),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                children: [
                  SvgPicture.asset(
                    'assets/svg/$photo2',
                    width: 40,
                    height: 40,
                    allowDrawingOutsideViewBox: true,
                  ),
                  Text(
                    name2,
                    style: AppStyles.bodyBoldMed,
                  ),
                  Text(
                    value2,
                    style: const TextStyle(
                      color: Color(0xFFBCBCBC),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
