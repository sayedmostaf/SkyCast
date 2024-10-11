class CurrentWeatherModel {
  Location? location;
  Current? current;
  CurrentWeatherModel({this.location, this.current});
  CurrentWeatherModel.fromJson(Map<String, dynamic> json) {
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    current =
        json['current'] != null ? Current.fromJson(json['current']) : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (location != null) {
      data['location'] = location!.toJson();
    }
    if (current != null) {
      data['current'] = current!.toJson();
    }
    return data;
  }
}

class Location {
  String? name, country;
  double? lat, lon;
  String? localtime;
  Location({this.name, this.country, this.lat, this.lon, this.localtime});

  Location.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    country = json['country'];
    lat = json['lat'];
    lon = json['lon'];
    localtime = json['localtime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'name': name,
      'country': country,
      'lat': lat,
      'lon': lon,
      'localtime': localtime,
    };
    return data;
  }
}

class Current {
  double? tempC, tempF;
  int? isDay;
  Condition? condition;
  double? windKph;
  String? windDir;
  int? humidity, cloud;
  double? feelslikeC, feelslikeF, visKm, uv;
  Current(
      {this.tempC,
      this.tempF,
      this.isDay,
      this.condition,
      this.windKph,
      this.windDir,
      this.humidity,
      this.cloud,
      this.feelslikeC,
      this.feelslikeF,
      this.visKm,
      this.uv});

  Current.fromJson(Map<String, dynamic> json) {
    tempC = json['temp_c'];
    tempF = json['temp_f'];
    isDay = json['is_day'];
    condition = json['condition'] != null
        ? Condition.fromJson(json['condition'])
        : null;
    windKph = json['wind_kph'];
    windDir = json['wind_dir'];
    humidity = json['humidity'];
    cloud = json['cloud'];
    feelslikeC = json['feelslike_c'];
    feelslikeF = json['feelslike_f'];
    visKm = json['vis_km'];
    uv = json['uv'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['temp_c'] = tempC;
    data['temp_f'] = tempF;
    data['is_day'] = isDay;
    if (condition != null) {
      data['condition'] = condition!.toJson();
    }
    data['wind_kph'] = windKph;
    data['wind_dir'] = windDir;
    data['humidity'] = humidity;
    data['cloud'] = cloud;
    data['feelslike_c'] = feelslikeC;
    data['feelslike_f'] = feelslikeF;
    data['vis_km'] = visKm;
    data['uv'] = uv;
    return data;
  }
}

class Condition {
  String? text, icon;
  int? code;
  Condition({text, this.icon, this.code});
  Condition.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    icon = json['icon'];
    code = json['code'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['text'] = text;
    data['icon'] = icon;
    data['code'] = code;
    return data;
  }
}
