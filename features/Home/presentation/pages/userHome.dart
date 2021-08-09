import 'package:flutter/material.dart';

import '../../../../core/elements.dart';

import 'package:my_app/features/Home/presentation/widgets/drwer.dart';
import 'homePgae.dart';
import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class UserHome extends StatefulWidget {
  List<Elements> elements;
  String choice;
  UserHome(this.choice, this.elements);
  @override
  State<StatefulWidget> createState() => HomeUser(choice, elements);
}

class HomeUser extends State<StatefulWidget> {
  String selected;
  List<Elements> tranMode;
  double imageSize = 80;
  double iconSize = 40;
  double bar = 80;
  double pad = 20;
  HomeUser(this.selected, this.tranMode);

  @override
  Widget build(BuildContext context) {
    final draw = TabController;
    double widthSize = MediaQuery.of(context).size.width;
    double heightSize = MediaQuery.of(context).size.height;
    if (MediaQuery.of(context).size.width > 600 &&
        MediaQuery.of(context).size.height > 500) {
      imageSize = 100;
      iconSize = 60;
      bar = 100;
      pad = 35;
    } else {
      imageSize = 65;
      iconSize = 50;
      bar = 80;
      pad = 10;
    }
    BottomBarController? _tabController;
    final _drawerController = ZoomDrawerController();

    return Scaffold(
        body: ZoomDrawer(
            controller: _drawerController,
            menuScreen: Settings(),
            mainScreen: DefaultBottomBarController(
                child: Example(selected, tranMode, _drawerController)),
            borderRadius: 24.0,
            showShadow: true,
            angle: 0.0,
            mainScreenScale: 0.2,
            slideWidth: MediaQuery.of(context).size.width *
                0.64 //* (ZoomDrawer.isRTL() ? .45 : 0.65),
            ));
  }
}
