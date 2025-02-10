import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';

int lastRequest = 0; //unix seconds
int timeToLive = 9; //seconds
String lastRequestedStopId = "";

class Prediction_Attributes {
  String? arrival_time;
  int? arrival_uncertainty;
  String? departure_time;
  int? departure_uncertainty;
  int? direction_id;
  bool? last_trip;
  String? revenue;
  int? drop_off_type;
  String? schedule_relationship;
  String? status;
  int? stop_sequence;
  String? update_type;
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

class Prediction {
  Prediction_Attributes attributes = Prediction_Attributes();
  String? id;
  Relationships relationships = Relationships();
  String? type;

  String toString() {
    if(id != null) {
      return id.toString();
    }
    return "null";
  }
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

class VehicleInformation {
  int id_lo = 0;
  int id_hi = 0;
  String type = "CRRC";

  VehicleInformation(int _id_lo, int _id_hi, String _type) {
    id_lo = _id_lo;
    id_hi = _id_hi;
    type = _type;
  }

  bool idInRange(int id) {
    return (id >= id_lo) && (id <= id_hi);
  }
}


List<String> tripIDs = [];
List<Prediction> predictions = [];
Map<String, Trip> trips = Map<String, Trip>();
Map<String, Vehicle> vehicles = Map<String, Vehicle>();

Future<String> getSchedules(String stopID, int lookAheadMinutes) async {
  DateTime now = DateTime.now();

  //prevent API spam
  if(lastRequest + timeToLive > (now.toUtc().millisecondsSinceEpoch/1000).toInt() && lastRequestedStopId == stopID) {
    return "CheckLastRequest";
  }
  lastRequestedStopId = stopID;
  lastRequest = (now.toUtc().millisecondsSinceEpoch/1000).toInt();

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

  var urlString = "https://api-v3.mbta.com/predictions?filter[stop]="+stopID+"&include=vehicle,trip&sort=arrival_time";
  log(urlString);
  var url = Uri.parse(urlString);
  var response = await http.get(url);
  return response.body;
}

void parseAPIResponse(String response) {
  if(response == "CheckLastRequest") {
    return;
  }
  var apiResponse = jsonDecode(response);
  predictions = [];
  for(int i = 0; i < apiResponse["data"].length; i++) {
    String id = apiResponse["data"][i]["id"];
    predictions.add(Prediction());

    predictions[i].id = id;
    predictions[i].type = apiResponse["data"][i]["type"];
    
    predictions[i].attributes.arrival_time          = apiResponse["data"][i]["attributes"]["arrival_time"];
    predictions[i].attributes.arrival_uncertainty   = apiResponse["data"][i]["attributes"]["arrival_uncertainty"];
    predictions[i].attributes.departure_time        = apiResponse["data"][i]["attributes"]["departure_time"];
    predictions[i].attributes.departure_uncertainty = apiResponse["data"][i]["attributes"]["departure_uncertainty"];
    predictions[i].attributes.direction_id          = apiResponse["data"][i]["attributes"]["direction_id"];
    predictions[i].attributes.last_trip             = apiResponse["data"][i]["attributes"]["last_trip"];
    predictions[i].attributes.revenue               = apiResponse["data"][i]["attributes"]["revenue"];
    predictions[i].attributes.drop_off_type         = apiResponse["data"][i]["attributes"]["drop_off_type"];
    predictions[i].attributes.schedule_relationship = apiResponse["data"][i]["attributes"]["schedule_relationship"];
    predictions[i].attributes.status                = apiResponse["data"][i]["attributes"]["status"];
    predictions[i].attributes.stop_sequence         = apiResponse["data"][i]["attributes"]["stop_sequence"];
    predictions[i].attributes.update_type           = apiResponse["data"][i]["attributes"]["update_type"];
  
    predictions[i].relationships.route   = Data(apiResponse["data"][i]["relationships"]["route"]["data"]["id"],   apiResponse["data"][i]["relationships"]["route"]["data"]["type"]);
    predictions[i].relationships.stop    = Data(apiResponse["data"][i]["relationships"]["stop"]["data"]["id"],    apiResponse["data"][i]["relationships"]["stop"]["data"]["type"]);
    predictions[i].relationships.trip    = Data(apiResponse["data"][i]["relationships"]["trip"]["data"]["id"],    apiResponse["data"][i]["relationships"]["trip"]["data"]["type"]);

    if(apiResponse["data"][i]["relationships"]["vehicle"]["data"] != null) {
      predictions[i].relationships.vehicle = Data(apiResponse["data"][i]["relationships"]["vehicle"]["data"]["id"], apiResponse["data"][i]["relationships"]["vehicle"]["data"]["type"]);
      vehicles[predictions[i].relationships.vehicle!.id] = Vehicle();
    }
    trips[predictions[i].relationships.trip!.id] = Trip();
  }

  if(apiResponse["included"] == null) {
    log("included is null");
    log(response);
    return;
  }

  for(int i = 0; i < apiResponse["included"].length; i++) {
    String id = apiResponse["included"][i]["id"];

    if(apiResponse["included"][i]["type"] == "trip") {
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
    }

    else if (apiResponse["included"][i]["type"] == "vehicle") {
      vehicles[id] = Vehicle();

      vehicles[id]!.id                               = apiResponse["included"][i]["id"];

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
}

int timeToArrive(Prediction schedule) {
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

Map<String, List<VehicleInformation>> vehicleInfo = {
  "Blue": [
    VehicleInformation(0700, 0793, "Siemens")
  ],
  "Orange": [
    VehicleInformation(1400, 1551, "CRRC")
  ],
  "Red": [
    VehicleInformation(1500, 1523, "Pullman-Standard"),
    VehicleInformation(1600, 1651, "Pullman-Standard"),
    VehicleInformation(1700, 1757, "UTDC"),
    VehicleInformation(1800, 1885, "Bombardier"),
    VehicleInformation(1900, 2151, "CRRC"),
  ],
  "Green": [
    VehicleInformation(3072, 3096, "Pullman-Standard"),
    VehicleInformation(3222, 3271, "Pullman-Standard"),

    VehicleInformation(3234, 3234, "Pullman-Standard"),
    VehicleInformation(3260, 3260, "Pullman-Standard"),
    VehicleInformation(3265, 3265, "Pullman-Standard"),

    VehicleInformation(3600, 3699, "Kinki-Sharyo"),
    VehicleInformation(3700, 3719, "Kinki-Sharyo"),

    VehicleInformation(3800, 3894, "Breda"),

    VehicleInformation(3900, 3923, "CAF"),
    VehicleInformation(4001, 4102, "CAF"),
  ],
  "CR": [
    VehicleInformation(1025, 1033, "F40PH-3C"),
    VehicleInformation(1034, 1036, "F40PH-3C"),
    VehicleInformation(1050, 1067, "F40PH-3C"),
    VehicleInformation(1068, 1075, "F40PH-3C"),

    VehicleInformation(1115, 1139, "GP40MC"),

    VehicleInformation(2000, 2039, "HSP46"),

    VehicleInformation(200, 202, "BTC-1C"),
    VehicleInformation(204, 214, "BTC-1C"),
    VehicleInformation(216, 258, "BTC-1C"),

    VehicleInformation(350, 389, "BTC-1A"),

    VehicleInformation(500, 532, "BTC-3"),
    VehicleInformation(533, 536, "BTC-3"),
    VehicleInformation(540, 540, "BTC-3"),

    VehicleInformation(600, 653, "BTC-1B"),

    VehicleInformation(700, 749, "BTC-4"),
    VehicleInformation(750, 766, "BTC-4A"),
    VehicleInformation(767, 781, "BTC-4B"),
    VehicleInformation(800, 846, "BTC-4D"),
    VehicleInformation(847, 886, "BTC-4D"),
    VehicleInformation(900, 932, "BTC-4C"),

    VehicleInformation(1500, 1533, "CTC-3"),
    VehicleInformation(1600, 1652, "CTC-1B"),
    VehicleInformation(1700, 1724, "CTC-4"),
    VehicleInformation(1800, 1827, "CTC-5"),
    VehicleInformation(1828, 1870, "CTC-5"),
  ],
};


String getVehicleInfo(int id, String line) {
  line = line.split("-")[0];
  // log(line);

  // try {
  for(int i = 0; i < vehicleInfo[line]!.length; i++) {
    if(vehicleInfo[line]![i].idInRange(id)) {
      return vehicleInfo[line]![i].type;
    }
  }
  // } catch (e) {
  //   return "";
  // }


  return "";
}