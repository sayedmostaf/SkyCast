import 'package:flutter/material.dart';
import 'package:sky_cast/core/themes/app_styles.dart';

class DrawerLocationWidget extends StatelessWidget {
  const DrawerLocationWidget(
      {super.key,
      this.icon,
      required this.location,
      this.imageUrl,
      required this.temp});
  final IconData? icon;
  final String location;
  final String? imageUrl;
  final String temp;

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.hardEdge,
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              if (icon != null) ...[
                Icon(icon),
              ],
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 4,
                child: Text(
                  location,
                  style: AppStyles.bodyMediumLarge,
                  overflow: TextOverflow.visible,
                ),
              ),
              const Spacer(),
              if (imageUrl != null)
                Image.network(
                  "https:$imageUrl",
                  scale: 2,
                ),
              const SizedBox(
                width: 10,
              ),
              Text(temp),
            ],
          ),
        ),
      ),
    );
  }
}
