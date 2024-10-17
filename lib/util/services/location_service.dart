import 'package:dartz/dartz.dart';
import 'package:location/location.dart';
import 'package:sky_cast/models/enums.dart';
import 'package:sky_cast/util/helpers/app_helper.dart';

class LocationService {
  Future<Either<LocationError, LocationData>> getLocation() async {
    bool isOnline = await AppHelper.checkInternet();
    if (isOnline) {
      Location location = Location();
      bool serviceEnabled;
      PermissionStatus permissionStatus;
      LocationData locationData;
      serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          return const Left(LocationError.notEnabled);
        }
      }
      permissionStatus = await location.hasPermission();
      if (permissionStatus == PermissionStatus.denied) {
        permissionStatus = await location.requestPermission();
        if (permissionStatus == PermissionStatus.granted) {
          return const Left(LocationError.denied);
        }
      }
      locationData = await location.getLocation();
      return Right(locationData);
    } else {
      return const Left(LocationError.offline);
    }
  }
}
