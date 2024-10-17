import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky_cast/controller/settings_controller.dart';
import 'package:sky_cast/core/themes/app_styles.dart';
import 'package:sky_cast/view/widgets/settings/popup_options.dart';
import 'package:sky_cast/view/widgets/settings/popup_settings_menu_item.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle:
            const TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
        title: const Text('Weather settings'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: GetBuilder<SettingsController>(
            builder: (controller) => SingleChildScrollView(
                child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF212121),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      PopupSettingsMenuItem(
                        isTop: true,
                        property: 'Unit',
                        value: '˚${controller.unit}',
                        options: (context) => PopupOptions.unit(controller),
                      ),
                      customDivider(),
                      PopupSettingsMenuItem(
                        property: 'Local Weather',
                        value: 'Agree',
                        options: (context) =>
                            PopupOptions.localWeather(controller),
                      ),
                      customDivider(),
                      PopupSettingsMenuItem(
                        isBottom: true,
                        property: 'Auto Refresh',
                        value: 'Every ${controller.refreshTime.inHours} hours',
                        options: (context) =>
                            PopupOptions.autoRefresh(controller),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  decoration: BoxDecoration(
                      color: const Color(0xFF212121),
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Theme',
                            style: AppStyles.bodyMediumLarge,
                          ),
                          Text(
                            controller.isDarkTheme ? 'Light mode' : 'Dark mode',
                            style: AppStyles.bodyRegularLarge
                                .copyWith(color: Colors.blue),
                          )
                        ],
                      ),
                      Switch(
                        value: controller.isDarkTheme,
                        onChanged: (value) => controller.switchTheme(value),
                      )
                    ],
                  ),
                )
              ],
            )),
          ),
        ),
      ),
    );
  }

  Divider customDivider() {
    return const Divider(
      height: 0,
      indent: 15,
      endIndent: 15,
    );
  }
}
