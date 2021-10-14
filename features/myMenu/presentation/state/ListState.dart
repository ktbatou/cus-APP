import 'package:flutter/material.dart';
import 'package:my_app/core/allChoices.dart';
import 'package:my_app/core/elements.dart';
import 'package:my_app/features/myMenu/presentation/widgets/MenuList.dart';
import 'package:provider/provider.dart';

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
