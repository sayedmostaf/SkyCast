import 'package:flutter/material.dart';
import 'package:sky_cast/controller/settings_controller.dart';

class PopupOptions {
  static List<PopupMenuItem<Text>> unit(SettingsController controller) => [
        PopupMenuItem(
          onTap: () => controller.setUnit('C'),
          child: const Text("C˚"),
        ),
        PopupMenuItem(
          onTap: () => controller.setUnit('F'),
          child: const Text("F˚"),
        ),
      ];
  static List<PopupMenuItem<Text>> localWeather(
          SettingsController controller) =>
      [
        const PopupMenuItem(
          child: Text("Agree"),
        ),
        const PopupMenuItem(
          child: Text("Disagree"),
        ),
      ];
  static List<PopupMenuItem<Text>> autoRefresh(SettingsController controller) =>
      [
        const PopupMenuItem(
          child: Text("Never"),
        ),
        PopupMenuItem<Text>(
          onTap: () => controller.setRefreshTime(1),
          child: const Text("Every 1 hour"),
        ),
        PopupMenuItem<Text>(
          onTap: () => controller.setRefreshTime(3),
          child: const Text("Every 3 hour"),
        ),
        PopupMenuItem<Text>(
          onTap: () => controller.setRefreshTime(6),
          child: const Text("Every 6 hour"),
        ),
        PopupMenuItem<Text>(
          onTap: () => controller.setRefreshTime(12),
          child: const Text("Every 12 hour"),
        ),
        PopupMenuItem<Text>(
          onTap: () => controller.setRefreshTime(24),
          child: const Text("Every 24 hour"),
        ),
      ];
}
