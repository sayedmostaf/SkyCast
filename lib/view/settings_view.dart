import 'package:flutter/material.dart';
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
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF212121),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  PopupSettingsMenuItem(
                    isTop: true,
                    property: 'Unit',
                    value: '˚C',
                    options: (context) => const [
                      PopupMenuItem(
                        child: Text('C˚'),
                      ),
                      PopupMenuItem(
                        child: Text('F˚'),
                      ),
                    ],
                  ),
                  customDivider(),
                  PopupSettingsMenuItem(
                    property: 'Local Weather',
                    value: 'Agree',
                    options: (context) => const [
                      PopupMenuItem(
                        child: Text('Agree'),
                      ),
                      PopupMenuItem(
                        child: Text('Disagree'),
                      ),
                    ],
                  ),
                  customDivider(),
                  PopupSettingsMenuItem(
                    isBottom: true,
                    property: 'Auto Refresh',
                    value: 'Every Hour',
                    options: (context) => const [
                      PopupMenuItem(
                        child: Text("Never"),
                      ),
                      PopupMenuItem(
                        child: Text('Every 3 hour'),
                      ),
                      PopupMenuItem(
                        child: Text('Every 6 hour'),
                      ),
                      PopupMenuItem(
                        child: Text('Every 12 hour'),
                      ),
                      PopupMenuItem(
                        child: Text('Every 24 hour'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
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
