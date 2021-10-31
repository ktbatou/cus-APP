import 'package:my_app/core/elements.dart';
import 'package:flutter/material.dart';

List<Elements> AllChoices() {
  List<Elements> choices = [
    Elements(key: "voiture", selected: false, icon: Icons.directions_car),
    Elements(key: "velo", selected: false, icon: Icons.directions_bike_rounded),
    Elements(key: "moto", selected: false, icon: Icons.motorcycle_outlined),
    Elements(
        key: "bus",
        selected: false,
        icon: Icons.directions_bus_filled_outlined),
    Elements(
        key: "miniBus", selected: false, icon: Icons.directions_bus_filled),
    Elements(key: "tram", selected: false, icon: Icons.tram_outlined),
    Elements(key: "train", selected: false, icon: Icons.directions_railway),
    Elements(key: "courire", selected: false, icon: Icons.directions_run_sharp),
    Elements(
        key: "marcher", selected: false, icon: Icons.directions_walk_outlined),
  ];
  return choices;
}
