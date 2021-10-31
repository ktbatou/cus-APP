import 'package:flutter/material.dart';
import 'package:my_app/core/elements.dart';

class ListState with ChangeNotifier {
  List<Elements> _menuList = [];

  List<Elements> get menuList => _menuList;

  void addToMenuList(List<Elements> newMenu) {
    _menuList = newMenu;
    notifyListeners();
  }

  void changeSelectedStatus(int index, bool state) {
    _menuList[index].selected = state;
    notifyListeners();
  }
}
