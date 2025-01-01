import 'package:flutter/material.dart';


String getColor(String name) {
  name = name.split("-")[0];
  switch(name) {
    case "Red":
      return "#DA291C";
    case "Blue":
      return "#003DA5";
    case "Orange":
      return "#ED8B00";
    case "Green":
      return "#00843D";
    case "CR":
      return "#80276C";
    case "Shuttle":
      return "#FFC72C";
  }
  return "#888888";
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

//for any stations with multiple colors, this is a fixed color for them.
String getStationColor(String station_id, String entryOneColor) {
  switch (station_id) {

    case "place-state": //state
      return getColor("Orange");
    case "place-dwnxg": //dtx
      return getColor("Red");
    case "place-pktrm": //pk st
      return getColor("Green");
    case "place-gover": //government
      return getColor("Blue");

    case "place-ogmnl": //oak grove
    case "place-mlmnl": //malden center
    case "place-haecl": //haymkt
    case "place-bbsta": //back bay
    case "place-rugg":  //ruggles
    case "place-forhl": //frst hills
      return getColor("Orange");

    case "place-north": //north
    case "place-sstat": //south
      return getColor("CR");

    case "place-portr": //porter
    case "place-jfk":   //umass
    case "place-qnctr": //quincy
    case "place-brntn": //braintree
    case "place-harsq": //harvard square
      return getColor("Red");
  }

  return entryOneColor;
}