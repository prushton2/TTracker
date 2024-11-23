import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';

class Schedule_Attributes {
  String? arrival_time;
  String? departure_time;
  int? direction_id;
  int? drop_off_type;
  int? pickup_type;
  String? stop_headsign;
  int? stop_sequence;
  bool? timepoint;
}

class Trip_Attributes {
  int? bikes_allowed;
  String? block_id;
  int? direction_id;
  String? headsign;
  String? name;
  String? revenue;
  int? wheelchair_accessible;
}

class Vehicle_Attributes {
  int? bearing;
  List<Carriage> carriages = [];
  String? current_status;
  int? current_stop_sequence;
  int? direction_id;
  String? label;
  double? latitude;
  double? longitude;
  String? occupancy_status;
  String? revenue;
  double? speed;
}

class Carriage {
  String? label;
  int? occupancy_percentage;
  String? occupancy_status;
}

class Relationships {
  Data? route;
  Data? stop;
  Data? trip;
  Data? route_pattern;
  Data? service;
  Data? shape;
}

class Data {
  String id = "";
  String type = "";

  Data(String i, String t) {
    id = i;
    type = t;
  }
}

class Schedule {
  Schedule_Attributes attributes = Schedule_Attributes();
  String? id;
  Relationships relationships = Relationships();
  String? type;
}

class Trip {
  Trip_Attributes attributes = Trip_Attributes();
  String? id;
  Relationships relationships = Relationships();
  String? type;
}

class Vehicle {
  Vehicle_Attributes attributes = Vehicle_Attributes();
  String? id;
  String? type;
}



List<String> tripIDs = [];
List<Schedule> schedules = [];
Map<String, Trip> trips = Map<String, Trip>();
Map<String, Vehicle> vehicles = Map<String, Vehicle>();

Future<String> getSchedules(String stopID, int lookAheadMinutes) async {
  DateTime now = DateTime.now();
  DateTime end = DateTime.now().add(Duration(minutes: lookAheadMinutes));
  var formatter = DateFormat("HH:mm");
  String fmt_now = formatter.format(now);
  String fmt_end = formatter.format(end);

  if(int.parse(fmt_now.split(":")[0]) <= 2) {
    fmt_now = (int.parse(fmt_now.split(":")[0]) + 24).toString() + ":" + fmt_now.split(":")[1];
  }
  if(int.parse(fmt_end.split(":")[0]) <= 2) {
    fmt_end = (int.parse(fmt_end.split(":")[0]) + 24).toString() + ":" + fmt_end.split(":")[1];
  }

  var urlString = "https://api-v3.mbta.com/schedules?filter[stop]="+stopID+"&filter[min_time]="+fmt_now+"&filter[max_time]="+fmt_end+"&include=trip&sort=arrival_time";
  // var urlString = "https://api-v3.mbta.com/schedules?filter[stop]="+stopID+"&filter[min_time]=21:30&filter[max_time]=22:30&include=trip&sort=arrival_time";
  var url = Uri.parse(urlString);
  var response = await http.get(url);
  return response.body;
}

void parseAPIResponse(String response) {
  var apiResponse = jsonDecode(response);
  schedules = [];
  for(int i = 0; i < apiResponse["data"].length; i++) {
    String id = apiResponse["data"][i]["id"];
    schedules.add(Schedule());

    schedules[i].id = id;
    schedules[i].type = apiResponse["data"][i]["type"];

    schedules[i].attributes.arrival_time   = apiResponse["data"][i]["attributes"]["arrival_time"];
    schedules[i].attributes.departure_time = apiResponse["data"][i]["attributes"]["departure_time"];
    schedules[i].attributes.direction_id   = apiResponse["data"][i]["attributes"]["direction_id"];
    schedules[i].attributes.drop_off_type  = apiResponse["data"][i]["attributes"]["drop_off_type"];
    schedules[i].attributes.pickup_type    = apiResponse["data"][i]["attributes"]["pickup_type"];
    schedules[i].attributes.stop_headsign  = apiResponse["data"][i]["attributes"]["stop_headsign"];
    schedules[i].attributes.stop_sequence  = apiResponse["data"][i]["attributes"]["stop_sequence"];
    schedules[i].attributes.timepoint      = apiResponse["data"][i]["attributes"]["timepoint"];

    schedules[i].relationships.route = Data(apiResponse["data"][i]["relationships"]["route"]["data"]["id"], apiResponse["data"][i]["relationships"]["route"]["data"]["type"]);
    schedules[i].relationships.stop  = Data(apiResponse["data"][i]["relationships"]["stop"]["data"]["id"],  apiResponse["data"][i]["relationships"]["stop"]["data"]["type"]);
    schedules[i].relationships.trip  = Data(apiResponse["data"][i]["relationships"]["trip"]["data"]["id"],  apiResponse["data"][i]["relationships"]["trip"]["data"]["type"]);
  }

  trips = Map<String, Trip>();
  tripIDs = [];
  if(apiResponse["included"] == null) {
    return;
  }
  for(int i = 0; i < apiResponse["included"].length; i++) {
    String id = apiResponse["included"][i]["id"];
    tripIDs.add(id);
    trips[id] = Trip();

    trips[id]!.id   = id;
    trips[id]!.type = apiResponse["included"][i]["type"];

    trips[id]!.attributes.bikes_allowed          = apiResponse["included"][i]["attributes"]["bikes_allowed"];
    trips[id]!.attributes.block_id               = apiResponse["included"][i]["attributes"]["block_id"];
    trips[id]!.attributes.direction_id           = apiResponse["included"][i]["attributes"]["direction_id"];
    trips[id]!.attributes.headsign               = apiResponse["included"][i]["attributes"]["headsign"];
    trips[id]!.attributes.name                   = apiResponse["included"][i]["attributes"]["name"];
    trips[id]!.attributes.revenue                = apiResponse["included"][i]["attributes"]["revenue"];
    trips[id]!.attributes.wheelchair_accessible  = apiResponse["included"][i]["attributes"]["wheelchair_accessible"];

    trips[id]!.relationships.route          = Data(apiResponse["included"][i]["relationships"]["route"]["data"]["id"],         apiResponse["included"][i]["relationships"]["route"]["data"]["type"]);
    trips[id]!.relationships.route_pattern  = Data(apiResponse["included"][i]["relationships"]["route_pattern"]["data"]["id"], apiResponse["included"][i]["relationships"]["route_pattern"]["data"]["type"]);
    trips[id]!.relationships.service        = Data(apiResponse["included"][i]["relationships"]["service"]["data"]["id"],       apiResponse["included"][i]["relationships"]["service"]["data"]["type"]);
    trips[id]!.relationships.shape          = Data(apiResponse["included"][i]["relationships"]["shape"]["data"]["id"],         apiResponse["included"][i]["relationships"]["shape"]["data"]["type"]);
  }
}

Future<String> getVehicleData(List<String> tripIDs) async {
  var urlString = "https://api-v3.mbta.com/trips?filter[id]="+tripIDs.join(",")+"&include=vehicle";
  var url = Uri.parse(urlString);
  var response = await http.get(url);
  return response.body;
}

void parseVehicles(String data) {
  var apiResponse = jsonDecode(data);
  vehicles = Map<String, Vehicle>();

  for(int i = 0; i < apiResponse["data"].length; i++) {
    String id = apiResponse["data"][i]["id"];
    if(vehicles[id] == null) {
      vehicles[id] = Vehicle();

      vehicles[id]!.attributes.bearing               = -1;
      vehicles[id]!.attributes.carriages             = [];
      vehicles[id]!.attributes.current_status        = "";
      vehicles[id]!.attributes.current_stop_sequence = -1;
      vehicles[id]!.attributes.direction_id          = -1;
      vehicles[id]!.attributes.label                 = "";
      vehicles[id]!.attributes.latitude              = -1;
      vehicles[id]!.attributes.longitude             = -1;
      vehicles[id]!.attributes.occupancy_status      = "";
      vehicles[id]!.attributes.revenue               = "";
      vehicles[id]!.attributes.speed                 = -1;
    }
  }

  if(apiResponse["included"] == null) {
    return;
  }
  for(int i = 0; i < apiResponse["included"].length; i++) {
    String id = apiResponse["included"][i]["relationships"]["trip"]['data']["id"];

    vehicles[id] = Vehicle();
    vehicles[id]!.attributes.bearing               = apiResponse["included"][i]["attributes"]["bearing"];
    vehicles[id]!.attributes.carriages = [];
    vehicles[id]!.attributes.current_status        = apiResponse["included"][i]["attributes"]["current_status"];
    vehicles[id]!.attributes.current_stop_sequence = apiResponse["included"][i]["attributes"]["current_stop_sequence"];
    vehicles[id]!.attributes.direction_id          = apiResponse["included"][i]["attributes"]["direction_id"];
    vehicles[id]!.attributes.label                 = apiResponse["included"][i]["attributes"]["label"];
    vehicles[id]!.attributes.latitude              = apiResponse["included"][i]["attributes"]["latitude"];
    vehicles[id]!.attributes.longitude             = apiResponse["included"][i]["attributes"]["longitude"];
    vehicles[id]!.attributes.occupancy_status      = apiResponse["included"][i]["attributes"]["occupancy_status"];
    vehicles[id]!.attributes.revenue               = apiResponse["included"][i]["attributes"]["revenue"];
    vehicles[id]!.attributes.speed                 = apiResponse["included"][i]["attributes"]["speed"];

    for(int j = 0; j < apiResponse["included"][i]["attributes"]["carriages"].length; j++) {
      vehicles[id]!.attributes.carriages.add(Carriage());
      vehicles[id]!.attributes.carriages[j].occupancy_status     = apiResponse["included"][i]["attributes"]["carriages"][j]["occupancy_status"];
      vehicles[id]!.attributes.carriages[j].occupancy_percentage = apiResponse["included"][i]["attributes"]["carriages"][j]["occupancy_percentage"];
      vehicles[id]!.attributes.carriages[j].label                = apiResponse["included"][i]["attributes"]["carriages"][j]["label"];
    }
  }
}

int timeToArrive(Schedule schedule) {
  if(schedule.attributes.arrival_time == null) {
    return -1;
  }

  String formattedDate = schedule.attributes.arrival_time!.split("-").sublist(0, 3).join("-").replaceAll("T", " ");
  var arrival = DateTime.parse(formattedDate);
  var now = DateTime.now();
  var delta = arrival.difference(now);
  return delta.inSeconds;
}

String formatWord(String word, String type) {
  word = word.replaceAll("_", " ");
  if(word.length >= 1) {
    word = "${word[0]}${word.substring(1).toLowerCase()}";
  }
  switch(type) {
    case "current_status":
      word = word.replaceAll(" at", "").replaceAll(" to", "");
      break;
    default:
      break;
  }
  return word;
}