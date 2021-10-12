import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_app/core/allChoices.dart';
import 'package:my_app/core/elements.dart';
import 'package:my_app/features/map/presentation/widgets/map.dart';
import 'package:flutter/material.dart';

Map icons = {
  'Moto': Icons.motorcycle_outlined,
  'Voiture': Icons.directions_car,
  'Velo': Icons.directions_bike_outlined,
  'Bus': Icons.directions_bus_filled_outlined,
  'MiniBus': Icons.directions_bus_filled,
  'Courire': Icons.directions_run_sharp,
  'Marcher': Icons.directions_walk_outlined,
  'Tram': Icons.tram_outlined,
  'Train': Icons.directions_railway
};

List<Elements> getList(List<String> choices) {
  List<Elements> newChoices = [];
  choices.forEach((element) {
    var key = element;
    var icon = icons[element];
    var choice = Elements(key: key, selected: true, icon: icon);
    newChoices.add(choice);
  });
  return newChoices;
}

List<Elements> mergedList(List<Elements> selected) {
  List<Elements> allChoices = AllChoices();

  allChoices.forEach((element) {
    selected.forEach((e) {
      if (e.key == element.key) {
        element.selected = true;
      }
    });
  });
  return allChoices;
}
