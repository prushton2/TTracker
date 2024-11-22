// import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';
import 'dart:core';
import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'Colors.dart' as TColors;
import 'API.dart' as API;

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
  String _id = "";
  String _color = "#888800";
  List<Widget> body = [];
  Map<String, bool> trains = Map<String, bool>();

  Future<void> initialize() async {

    String station = "";
    String id = "";

    String contents = await File('res/stops.json').readAsString();

    int index = 199;

    var stops = jsonDecode(contents);
    station = stops["data"][index]["attributes"]["name"];
    id = stops["data"][index]["id"];

    trains = Map<String, bool>();

    String trainData = await API.getSchedules(id, 60);
    API.  parseAPIResponse(trainData);

    body = [];

    for(int i = 0; i<API.schedules.length; i++) {
      API.Schedule schedule = API.schedules[i];
      API.Trip trip = API.trips[schedule.relationships.trip!.id]!;

      String destination = trip.attributes.headsign!;
      String lineColor = TColors.getColor(schedule.relationships.route!.id); //trainData["data"][i]["relationships"]["route"]["data"]["id"]);

      if(trains[destination] != null) {
        continue;
      }

      if(API.timeToArrive(schedule) <= 0) {
        continue;
      }


      trains[destination] = true;

      String arriveIn = (API.timeToArrive(schedule)/60).toInt().toString()+"m";
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
                child: Text(trip.relationships.route!.id) //trainData["included"][i]["relationships"]["route"]["data"]["id"]+" Line"),
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
                child: Text(trip.attributes.headsign! + "     " + arriveIn ) //trainData["included"][i]["attributes"]["headsign"]),
            )
          ])
        )
      );
    }



    setState(() {
      _color = TColors.getStationColor(id, TColors.getColor(API.schedules[0].relationships.route!.id));
      _id = id;
      _station = station;
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: body,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: initialize,
        tooltip: 'Refresh',
        child: const Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
