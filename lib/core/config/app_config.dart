class AppConfig {
  static const String apiKey = '0435d0246321411fa8d151434241207';
  static const String baseUrl =
      'https://api.weatherapi.com/v1/forecast.json?key=$apiKey&days=8&aqi=no&alerts=yes';
  static const String searchUrl =
      "https://api.weatherapi.com/v1/search.json?key=$apiKey";
}
