// import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';
import 'dart:core';
// import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'dart:developer';

import 'Colors.dart' as TColors;
import 'API.dart' as API;
import 'Geolocator.dart' as Geolocator;
import 'stops.dart' as Stops;

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
      theme: ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: Colors.black12,
          onPrimary: Colors.white,
          secondary: Colors.blue,
          onSecondary: Colors.white,
          error: Colors.orange,
          onError: Colors.black,
          surface: Colors.black12,
          onSurface: Colors.white,
        ),
        useMaterial3: true,
      ),
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
  String _station = "";
  String _color = "#888888";
  List<Widget> _body = [];
  Map<String, bool> trains = Map<String, bool>();



  Future<void> initialize() async {
    String station = "";
    String id = "";

    Stops.Stop stopInfo = Stops.stopInfo["place-north"]!;

    try {
      var pos = await Geolocator.determinePosition();
      stopInfo = Geolocator.getNearestStop(pos.longitude, pos.latitude);
    } catch (e) {
      log(e.toString());
    }

    station = stopInfo.name;
    id = stopInfo.id;

    trains = Map<String, bool>();

    String trainData = await API.getSchedules(id, 60);
    API.parseAPIResponse(trainData);
    List<Widget> body = [];

    for(int i = 0; i<API.predictions.length; i++) {
      API.Prediction prediction = API.predictions[i];
      API.Trip trip = API.trips[prediction.relationships.trip!.id]!;
      API.Vehicle vehicle = API.Vehicle();

      if(prediction.relationships.vehicle != null) {
        vehicle = API.vehicles[prediction.relationships.vehicle!.id]!;
      }

      String destination = trip.attributes.headsign!;
      String lineColor = TColors.getColor(prediction.relationships.route!.id);

      if(trains[destination] != null) {
        continue;
      }

      if(API.timeToArrive(prediction) <= 0) {
        continue;
      }
      trains[destination] = true;

      List<Widget> carOccupancy = getCarOccupancy(vehicle);
      String nearestStop = "";

      if(vehicle.attributes.current_status == "STOPPED_AT") {
        nearestStop = " at "+Geolocator.getNearestStop(vehicle.attributes.longitude!, vehicle.attributes.latitude!).name;
      }

      String arriveIn = (API.timeToArrive(prediction)/60).toInt().toString()+"m";
      body.add(
        Container(
          margin: EdgeInsets.only(top: 20),
          child: Column(children: [
            Container(
                height: 50,
                width: MediaQuery.sizeOf(context).width-100,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: TColors.HexColor(lineColor)
                    ),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)
                    ),
                    color: TColors.HexColor(lineColor)
                ),
                padding: EdgeInsets.all(10),
                child: Text(prediction.relationships.route!.id)
            ),
            Container(
                width: MediaQuery.sizeOf(context).width-100,
                decoration: BoxDecoration(
                    border: Border.all (
                        strokeAlign: BorderSide.strokeAlignInside,
                        color: TColors.HexColor(lineColor)
                    ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)
                  )
                ),
                padding: EdgeInsets.all(20),
                margin: EdgeInsetsDirectional.only(bottom: 10),
                child: Align(alignment: Alignment.topLeft, child: Column(children: [
                  Text(trip.attributes.headsign! + "     "  + arriveIn+"\n"+API.formatWord(vehicle.attributes.current_status!, "current_status") + nearestStop, textAlign: TextAlign.left),
                  Row(children: carOccupancy)
                ]))
            )
          ])
        )
      );
    }



    setState(() {
      if(API.predictions.length >= 1) {
        _color = TColors.getColor(API.predictions[0].relationships.route!.id);
      } else {
        _color = "#888888";
      }
      _color = TColors.getStationColor(id, _color);
      _station = station;
      _body = body;
    });
  }

  List<Widget> getCarOccupancy(API.Vehicle vehicle) {
    // List<Widget> carOccupancy = [ColorFiltered(colorFilter: ColorFilter.mode(Colors.white, BlendMode.color), child: Image.asset("assets/icons/subway-locomotive.jpg", width: 10))];
    List<Widget> carOccupancy = [Text("L")];
    for(int j = 0; j < vehicle.attributes.carriages.length; j++) {

      Color color = Colors.white;
      if(vehicle.attributes.carriages[j].occupancy_percentage == null) {
        color = Colors.grey;
      } else if(vehicle.attributes.carriages[j].occupancy_percentage! > 60) {
        color = Colors.red;
      } else if (vehicle.attributes.carriages[j].occupancy_percentage! > 30) {
        color = Colors.orange;
      }
      carOccupancy.add(
          Text(
              "C",
              style: TextStyle(color: color)
          )
      );
    }
    return carOccupancy;
  }

  @override
  void initState() {
    initialize();
    Timer mytimer = Timer.periodic(Duration(seconds: 10), (timer) {
      initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    // initialize();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColors.HexColor(_color),
        title: Text(_station),
      ),
      body: Flex(
        direction: Axis.vertical,
        children: [Expanded(
          child: ListView(
            children: _body
          )
        )
      ])
    );
  }
}
