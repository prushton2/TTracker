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
    case "Green":
      return "#00843D";
    case "Green":
      return "#00843D";
    case "Green":
      return "#00843D";
    case "CR":
      return "#80276C";
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
    case "place-state":
      return getColor("Orange");
    case "place-dwnxg":
      return getColor("Red");
    case "place-pktrm":
      return getColor("Green");
    case "place-gover":
      return getColor("Blue");
    case "place-haecl":
      return getColor("Orange");
    case "place-north":
      return getColor("CR");
    case "place-sstat":
      return getColor("CR");
  }

  return entryOneColor;
}