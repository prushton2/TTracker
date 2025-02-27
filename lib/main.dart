// import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';
import 'dart:core';
// import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
import 'dart:developer';

import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart' as plp;
import "package:latlong2/latlong.dart" as latLng;

import 'Colors.dart' as TColors;
import 'stops.dart' as Stops;
import 'Shapes.dart' as Shapes;

void main() {
  runApp(const MyApp());
}

class Train {
  String destination = "";
  String line = "";
  int timeToArr = 0;
  List<int> occupancyPct = [];
  String status = "";
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Station Name',
      theme: ThemeData.dark(useMaterial3: true),
      // theme: ThemeData.dark; //(
      //   colorScheme: const ColorScheme(
      //     brightness: Brightness.dark,
      //     primary: Colors.black12,
      //     accentColor: Colors.black12
      //     // onPrimary: Colors.white,
      //     // secondary: Colors.blue,
      //     // onSecondary: Colors.white,
      //     // error: Colors.orange,
      //     // onError: Colors.black,
      //     // surface: Colors.black12,
      //     // onSurface: Colors.white,
      //   ),
      //   useMaterial3: true,
      // ),
      home: const MyHomePage(title: 'Station Name'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PolylineLayer subwayLines = PolylineLayer(polylines: []);
  MarkerLayer stations = MarkerLayer(markers: []);
  Widget? map; // = FlutterMap();

  void createPolyLines() {
    log("making poylines");
    plp.PolylinePoints polylinePoints = plp.PolylinePoints();

    subwayLines = PolylineLayer(polylines: []);

    for(String key in Shapes.lines.keys) {
      for(String polyline in Shapes.lines[key]!) {
        List<plp.PointLatLng> result = polylinePoints.decodePolyline(polyline);
        List<latLng.LatLng> points = result.map((e) => latLng.LatLng(e.latitude, e.longitude)).toList();

        subwayLines.polylines.add(
          Polyline(
              points: points,
              color: TColors.HexColor(TColors.getColor(key))
          )
        );
      }
    }
  }

  void createStations() {
    log("Making stations");
    stations = MarkerLayer(markers: []);

    for(String key in Stops.stopInfo.keys) {
      // log(Stops.stopInfo[key]!.id);
      stations.markers.add(
        Marker(
          point: latLng.LatLng(Stops.stopInfo[key]!.latitude, Stops.stopInfo[key]!.longitude),
          rotate: true,
          width: 50,
          height: 50,
          child:
            TextButton(
              onPressed: () {
                log("Tapped ${Stops.stopInfo[key]!.name}");
                Stops.selectedStop = Stops.stopInfo[key];
              },
              child: Image.asset(
                "assets/icons/MBTA.png",
                width: 10,
                height: 10
              ),
            ),
        )
      );
      // log(stations.markers.length.toString());
    }
  }



  @override
  Widget build(BuildContext context) {
    if(subwayLines.polylines.isEmpty) {
      createPolyLines();
    }

    // if(stations.markers.isEmpty) {
    createStations();
    // }
    map = null;
    // ??= only assigns value to a null variable
    map ??= FlutterMap(
      mapController: MapController(),
      options: const MapOptions(
          initialCenter: latLng.LatLng(42.36041830331139, -71.0580009624248),
          backgroundColor: Colors.black
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://a.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}.png',
          userAgentPackageName: 'dev.prushton.ttracker',
        ),
        subwayLines,
        stations
      ]
    );





    return map!;
  }
}
