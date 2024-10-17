import 'package:get/get.dart';
import 'package:sky_cast/controller/weather_controller.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WeatherController());
  }
}
