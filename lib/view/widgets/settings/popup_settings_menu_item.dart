import 'package:flutter/material.dart';
import 'package:sky_cast/core/themes/app_styles.dart';

class PopupSettingsMenuItem extends StatelessWidget {
  const PopupSettingsMenuItem({
    super.key,
    required this.property,
    required this.value,
    required this.options,
    this.isTop,
    this.isBottom,
  });
  final String property;
  final String value;
  final List<PopupMenuEntry<dynamic>> Function(BuildContext) options;
  final bool? isTop;
  final bool? isBottom;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.vertical(
        top: isTop != null ? const Radius.circular(15) : Radius.zero,
        bottom: isBottom != null ? const Radius.circular(15) : Radius.zero,
      ),
      child: PopupMenuButton(
        color: const Color(0xFF373737),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        itemBuilder: options,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                property,
                style: AppStyles.bodyMediumLarge,
              ),
              Text(
                value,
                style: AppStyles.bodyRegularLarge.copyWith(color: Colors.blue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
