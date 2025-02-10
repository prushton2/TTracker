import 'dart:core';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:developer';
import 'API.dart' as API;
import 'Colors.dart' as TColors;

Map<String, List<API.Prediction>> SortPredictions() {
  Map<String, List<API.Prediction>> sortedPredictions = Map<String, List<API.Prediction>>();

  for(int i = 0; i < API.predictions.length; i++) {
    String name = API.predictions[i].relationships.route!.id.split("-")[0];
    if(sortedPredictions[name] == null) {
      sortedPredictions[name] = [];
    }
    sortedPredictions[name]!.add(API.predictions[i]);
  }
  return sortedPredictions;
}


List<Widget> renderPredictions(List<API.Prediction>? predictions, BuildContext context) {
  List<Widget> body = [];
  Map<String, List<API.Prediction>> Destinations = Map<String, List<API.Prediction>>();

  if(predictions == null) {
    return [];
  }

  for(int i = 0; i < predictions.length; i++) {
    API.Trip trip = API.trips[predictions[i].relationships.trip!.id]!;

    if(Destinations[trip.attributes.headsign!] == null) {
      Destinations[trip.attributes.headsign!] = [];
    }
    
    Destinations[trip.attributes.headsign!]!.add(predictions[i]);
  }

  // API.Vehicle vehicle = API.Vehicle();
  for(String key in Destinations.keys) {

    API.Prediction prediction = Destinations[key]![0];
    API.Trip trip = API.trips[prediction.relationships.trip!.id]!;
    API.Vehicle vehicle = API.Vehicle();

    if(prediction.relationships.vehicle != null) {
      vehicle = API.vehicles[prediction.relationships.vehicle!.id]!;
    }

    String lineColor = TColors.getColor(prediction.relationships.route!.id);

    List<Widget> arrivalTimes = [];

    for(API.Prediction p in Destinations[key]!) {
      String arriveIn = (API.timeToArrive(p)/60).toInt().toString()+"m";

      arrivalTimes.add(
        Row(children: [Text(arriveIn), Spacer(), getCarOccupancy(vehicle)])
      );
    }


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
              child: Row(children: [Text(trip.attributes.headsign!), Spacer(), Text(prediction.relationships.route!.id)])
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
              child: Column(
                children: arrivalTimes,
              )
          )

        ])
      )
    );
  }



  return body;
}


Widget getCarOccupancy(API.Vehicle vehicle) {
  // List<Widget> carOccupancy = [ColorFiltered(colorFilter: ColorFilter.mode(Colors.white, BlendMode.color), child: Image.asset("assets/icons/subway-locomotive.jpg", width: 10))];
  List<Widget> carOccupancy = [];
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
        Icon(Icons.directions_transit_rounded, color: color)
    );
  }
  return Row(children: carOccupancy);
}



/*
for(int i = 0; i < predictions.length; i++) {

  API.Prediction prediction = API.predictions[i];
  API.Trip trip = API.trips[prediction.relationships.trip!.id]!;
  API.Vehicle vehicle = API.Vehicle();

  if(prediction.relationships.vehicle != null) {
    vehicle = API.vehicles[prediction.relationships.vehicle!.id]!;
  }

  // String destination = trip.attributes.headsign!;
  String lineColor = TColors.getColor(prediction.relationships.route!.id);
  List<Widget> carOccupancy = getCarOccupancy(vehicle);
  String nearestStop = "";

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
                child: Row(children: [Text(prediction.relationships.route!.id), Text(" " + trip.attributes.headsign!), Spacer(), Text(vehicle.id!)])
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
                  SizedBox(height: 30),
                  Row(children: carOccupancy)
                ]))
            )
          ])
      )
  );
}
*/