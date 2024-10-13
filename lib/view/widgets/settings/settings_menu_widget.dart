import 'package:flutter/material.dart';

class SettingsMenuWidget extends StatelessWidget {
  const SettingsMenuWidget(
      {super.key, required this.property, required this.value});
  final String property, value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(property),
          const SizedBox(
            height: 10,
          ),
          Text(value),
        ],
      ),
    );
  }
}
