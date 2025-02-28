import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';

int lastRequest = 0; //unix seconds
int timeToLive = 9; //seconds
String lastRequestedStopId = "";

class Vehicle {
  Vehicle_Attributes attributes = Vehicle_Attributes();
  String? id;
  String? type;
}

class Vehicle_Attributes {
  int? bearing = -1;
  List<Carriage> carriages = [];
  String? current_status = "";
  int? current_stop_sequence = -1;
  int? direction_id = -1;
  String? label = "";
  double? latitude = -1;
  double? longitude = -1;
  String? occupancy_status = "";
  String? revenue = "";
  double? speed = -1;
}

class Carriage {
  String? label;
  int? occupancy_percentage;
  String? occupancy_status;
}

class Trip {
  Trip_Attributes attributes = Trip_Attributes();
  String? id;
  Relationships relationships = Relationships();
  String? type;
}

class Trip_Attributes {
  int? bikes_allowed = -1;
  String? block_id = "";
  int? direction_id = -1;
  String? headsign = "";
  String? name = "";
  String? revenue = "";
  int? wheelchair_accessible = -1;
}

class Relationships {
  Data? route;
  Data? stop;
  Data? trip;
  Data? route_pattern;
  Data? service;
  Data? shape;
  Data? vehicle;
}

class Data {
  String id = "";
  String type = "";

  Data(String i, String t) {
    id = i;
    type = t;
  }
}

List<String> tripIDs = [];
// List<Prediction> predictions = [];
Map<String, Trip> trips = <String, Trip>{};
Map<String, Vehicle> vehicles = <String, Vehicle>{};

Future<void> getVehicleData() async {

  DateTime now = DateTime.now();

  //prevent API spam
  if(lastRequest + timeToLive > (now.toUtc().millisecondsSinceEpoch/1000).toInt()) {
    return;
  }
  // lastRequestedStopId = stopID;
  lastRequest = (now.toUtc().millisecondsSinceEpoch/1000).toInt();

  var urlString = "https://api-v3.mbta.com/vehicles?filter[route_type]=0,1";
  // log(urlString);
  var url = Uri.parse(urlString);
  var apiResponse = jsonDecode((await http.get(url)).body);

  for (int i = 0; i < apiResponse["data"].length; i++) {
    String id = apiResponse["data"][i]["id"];

    if (apiResponse["data"][i]["type"] == "trip") {
      tripIDs.add(id);
      trips[id] = Trip();

      trips[id]!.id = id;
      trips[id]!.type = apiResponse["data"][i]["type"];

      trips[id]!.attributes.bikes_allowed = apiResponse["data"][i]["attributes"]["bikes_allowed"];
      trips[id]!.attributes.block_id = apiResponse["data"][i]["attributes"]["block_id"];
      trips[id]!.attributes.direction_id = apiResponse["data"][i]["attributes"]["direction_id"];
      trips[id]!.attributes.headsign = apiResponse["data"][i]["attributes"]["headsign"];
      trips[id]!.attributes.name = apiResponse["data"][i]["attributes"]["name"];
      trips[id]!.attributes.revenue = apiResponse["data"][i]["attributes"]["revenue"];
      trips[id]!.attributes.wheelchair_accessible = apiResponse["data"][i]["attributes"]["wheelchair_accessible"];
    }

    else if (apiResponse["data"][i]["type"] == "vehicle") {
      vehicles[id] = Vehicle();

      vehicles[id]!.id = apiResponse["data"][i]["id"];

      vehicles[id]!.attributes.bearing = apiResponse["data"][i]["attributes"]["bearing"];
      vehicles[id]!.attributes.carriages = [];
      vehicles[id]!.attributes.current_status = apiResponse["data"][i]["attributes"]["current_status"];
      vehicles[id]!.attributes.current_stop_sequence = apiResponse["data"][i]["attributes"]["current_stop_sequence"];
      vehicles[id]!.attributes.direction_id = apiResponse["data"][i]["attributes"]["direction_id"];
      vehicles[id]!.attributes.label = apiResponse["data"][i]["attributes"]["label"];
      vehicles[id]!.attributes.latitude = apiResponse["data"][i]["attributes"]["latitude"];
      vehicles[id]!.attributes.longitude = apiResponse["data"][i]["attributes"]["longitude"];
      vehicles[id]!.attributes.occupancy_status = apiResponse["data"][i]["attributes"]["occupancy_status"];
      vehicles[id]!.attributes.revenue = apiResponse["data"][i]["attributes"]["revenue"];
      vehicles[id]!.attributes.speed = apiResponse["data"][i]["attributes"]["speed"];

      for (int j = 0; j < apiResponse["data"][i]["attributes"]["carriages"].length; j++) {
        vehicles[id]!.attributes.carriages.add(Carriage());
        vehicles[id]!.attributes.carriages[j].occupancy_status = apiResponse["data"][i]["attributes"]["carriages"][j]["occupancy_status"];
        vehicles[id]!.attributes.carriages[j].occupancy_percentage = apiResponse["data"][i]["attributes"]["carriages"][j]["occupancy_percentage"];
        vehicles[id]!.attributes.carriages[j].label = apiResponse["data"][i]["attributes"]["carriages"][j]["label"];
      }
    }
  }
}