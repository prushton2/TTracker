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


Stops.Stop getNearestStop(Position pos) {
  double lowestDistance = 360;
  Stops.Stop nearestStop = Stops.stopInfo[0];
  for(int i = 0; i < Stops.stopInfo.length; i++) {
    double dist = sqrt( pow(pos.latitude - Stops.stopInfo[i].latitude, 2) + pow(pos.longitude - Stops.stopInfo[i].longitude, 2));

    if(dist < lowestDistance) {
      lowestDistance = dist;
      nearestStop = Stops.stopInfo[i];
    }
  }

  if(lowestDistance == 360) {
    throw Exception("How");
  }
  return nearestStop;
}