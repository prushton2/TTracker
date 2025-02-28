// import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';
import 'dart:core';
// import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
import 'dart:developer';
import 'dart:async';

import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart' as plp;
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import "package:latlong2/latlong.dart" as latLng;

import 'Colors.dart' as TColors;
import 'stops.dart' as Stops;
import 'Shapes.dart' as Shapes;
import 'API.dart' as API;

void main() {
  runApp(const MyApp());
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
  MarkerLayer trains = MarkerLayer(markers: []);
  FlutterMap? map;

  MapController mapController = MapController();
  MapOptions options = const MapOptions(
      initialCenter: latLng.LatLng(42.36041830331139, -71.0580009624248),
      backgroundColor: Colors.black,
      keepAlive: true
  );

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

  MarkerLayer createStations() {
    log("Making stations");
    MarkerLayer stations = MarkerLayer(markers: []);

    for(String key in Stops.stopInfo.keys) {
      // log(Stops.stopInfo[key]!.id);
      stations.markers.add(
        Marker(
          point: latLng.LatLng(Stops.stopInfo[key]!.latitude, Stops.stopInfo[key]!.longitude),
          rotate: true,
          width: 50,
          height: 50,
          child: TextButton(
            onPressed: () {
              log("Tapped ${Stops.stopInfo[key]!.name}");
              setState(() {
                Stops.selectedStop = Stops.stopInfo[key];
              });
            },
            child: Image.asset(
              "assets/icons/MBTA.png",
              width: 10,
              height: 10
            ),
          ),
        )
      );

    }
    return stations;

  }

  void createTrains() {
    MarkerLayer newtrains = MarkerLayer(markers: []);

    for(String key in API.vehicles.keys) {
      newtrains.markers.add(
        Marker(
          key: Key(key),
          point: latLng.LatLng(API.vehicles[key]!.attributes.latitude!, API.vehicles[key]!.attributes.longitude!),
          // rotate: true,
          width: 10,
          // alignment: const Alignment(-5, -5),
          height: 10,
          child: TextButton(
              onPressed: () {},
              child: Transform.rotate(
                  angle: API.vehicles[key]!.attributes.bearing.toDouble(),
                  child: Icon(
                    Icons.arrow_circle_up,
                    color: TColors.HexColor(TColors.getColor(API.vehicles[key]!.relationships!.route!.id))
                )
              )
          )
        )
      );
    }
    setState(() {
      trains = newtrains;
    });
  }

  @override
  void initState() {
    Timer mytimer = Timer.periodic(Duration(seconds: 10), (timer) async {
      await API.getVehicleData();
      createTrains();
      // log("Created new vehicles");
      // log("Trains: " + trains.markers.length.toString());
    });
  }

  @override
  Widget build(BuildContext context) {

    // API.getVehicleData();

    if(subwayLines.polylines.isEmpty) {
      createPolyLines();
    }

    if(stations.markers.isEmpty) {
      stations = createStations();
    }

    map = FlutterMap(
        mapController: mapController,
        options: options,
        children: [
          TileLayer(
            urlTemplate: 'https://a.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}.png',
            userAgentPackageName: 'dev.prushton.ttracker',
          ),
          subwayLines,
          MarkerClusterLayerWidget(
            options: MarkerClusterLayerOptions(
              maxClusterRadius: 20,
              size: const Size(10, 10),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(50),
              maxZoom: 15,
              markers: trains.markers,
              builder: (context, markers) {
                return const Text("");
              },
            ),
          ),
          MarkerClusterLayerWidget(
            options: MarkerClusterLayerOptions(
              maxClusterRadius: 45,
              size: const Size(10, 10),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(50),
              maxZoom: 15,
              markers: stations.markers,
              builder: (context, markers) {
                return Image.asset(
                    "assets/icons/MBTA.png",
                    width: 10,
                    height: 10
                );
              },
            ),
          ),
        ]
    );

    if(Stops.selectedStop == null) {
      return map!;
    } else {
      return Stops.renderStopInfo();
    }
  }
}
