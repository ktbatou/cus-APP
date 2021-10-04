import 'package:my_app/core/elements.dart';
import 'package:flutter/material.dart';

List<Elements> AllChoices() {
  List<Elements> choices = [
    Elements(key: "Voiture", selected: false, icon: Icons.directions_car),
    Elements(key: "Velo", selected: false, icon: Icons.directions_bike_rounded),
    Elements(key: "Moto", selected: false, icon: Icons.motorcycle_outlined),
    Elements(
        key: "Bus",
        selected: false,
        icon: Icons.directions_bus_filled_outlined),
    Elements(
        key: "MiniBus", selected: false, icon: Icons.directions_bus_filled),
    Elements(key: "Tram", selected: false, icon: Icons.tram_outlined),
    Elements(key: "Train", selected: false, icon: Icons.directions_railway),
    Elements(key: "Courire", selected: false, icon: Icons.directions_run_sharp),
    Elements(
        key: "Marcher", selected: false, icon: Icons.directions_walk_outlined),
  ];
  return choices;
}
