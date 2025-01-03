import 'package:geolocator/geolocator.dart';
import 'stops.dart' as Stops;
import 'dart:math';

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}


Stops.Stop getNearestStop(double longitude, double latitude) {
  double lowestDistance = 360;
  String lowestID = "";
  for(String key in Stops.stopInfo.keys) {
    Stops.Stop value = Stops.stopInfo[key]!;
    double dist = sqrt(pow(latitude - value.latitude, 2) + pow(longitude - value.longitude, 2));

    if(dist < lowestDistance) {
      lowestDistance = dist;
      lowestID = key;
    }
  }

  if(lowestDistance == 360) {
    throw Exception("How");
  }
  return Stops.stopInfo[lowestID]!;
}