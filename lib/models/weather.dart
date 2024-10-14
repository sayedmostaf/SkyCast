import 'package:sky_cast/models/current_weather_model.dart';
import 'package:sky_cast/models/forecast_model.dart';

class Weather {
  CurrentWeatherModel currentWeatherModel;
  ForecastModel forecastModel;
  Weather({required this.currentWeatherModel, required this.forecastModel});
}
