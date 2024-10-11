import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sky_cast/models/current_weather_model.dart';
import 'package:sky_cast/models/forecast_model.dart';
import 'package:sky_cast/util/services/api_service.dart';

class WeatherController extends GetxController {
  final ApiService apiService = ApiService();
  late SharedPreferences sharedPreferences;
  String location = 'London';
  RxBool isLoading = false.obs;
  CurrentWeatherModel? weather;
  ForecastModel? forecastModel;
  Future<void> getCurrentWeather(String location) async {
    isLoading(true);
    await sharedPreferences.setString('location', location);
    this.location = location;
    var response = await apiService.getRequst(endPoint: '&q=$location');

    if (response != null) {
      print(response.toString());
      weather = CurrentWeatherModel.fromJson(response);
      forecastModel = ForecastModel.fromJson(response['forecast']);
    } else {
      print('req failed');
    }
    isLoading(false);
    update();
  }

  @override
  void onInit() async {
    await getCurrentWeather(location);
    sharedPreferences = await SharedPreferences.getInstance();
    location = sharedPreferences.getString('location') ?? location;
    super.onInit();
  }
}
