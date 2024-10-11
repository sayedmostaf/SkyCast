import 'package:flutter/material.dart';
import 'package:sky_cast/core/themes/app_themes.dart';
import 'package:sky_cast/view/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeView(),
      theme: AppThemes.darkTheme,
    );
  }
}
