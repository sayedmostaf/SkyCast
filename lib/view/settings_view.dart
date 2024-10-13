import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky_cast/view/widgets/settings/settings_menu_widget.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                PopupMenuButton(
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      padding: EdgeInsets.zero,
                      child: Text("C˚"),
                    ),
                    const PopupMenuItem(
                      child: Text("F˚"),
                    ),
                  ],
                  child: const SettingsMenuWidget(
                    property: 'Units',
                    value: 'C˚',
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
