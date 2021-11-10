import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_app/features/language/data/appLocalization.dart';
import 'package:my_app/features/language/data/provider/languageProvider.dart';
import 'package:my_app/features/language/presentation/pages/language.dart';
import 'package:my_app/features/map/presentation/widgets/map.dart';
import 'package:my_app/features/map/presentation/widgets/mapWidget.dart';
import 'package:provider/provider.dart';
import '../../../../core/elements.dart';
import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:glassmorphism/glassmorphism.dart';
import '../data/repositories/dataGetter.dart';
import 'package:move_to_background/move_to_background.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class Home extends StatefulWidget {
  final zoomDraw;

  String uid;

  Home(this.uid, this.zoomDraw);
  @override
  State<StatefulWidget> createState() => HomeState(uid: uid, draw: zoomDraw);
}

class HomeState extends State<StatefulWidget> {
  String? uid;
  String choice = "Vous n'avez pas encore choisir de mode!";
  String button = "chooseMode";
  double imageSize = 80;
  double iconSize = 40;
  double bar = 80;
  double pad = 20;
  double size = 15;
  double header = 0.07;
  double heightMap = 0.70;
  IconData? icon;
  final draw;
  HomeState({this.uid, this.draw});

  void responsive() {
    setState(() {});
  }

  void original() {}

  @override
  Widget build(BuildContext context) {
    var applang = Provider.of<AppLang>(context).appLocal;
    double widthSize = MediaQuery.of(context).size.width;
    double heightSize = MediaQuery.of(context).size.height;
    if (MediaQuery.of(context).size.width > 600) {
      setState(() {
        imageSize = 100;
        iconSize = 60;
        bar = 100;
        pad = 35;
        header = 0.14;
        heightMap = 0.55;
      });
    } else
      setState(() {
        imageSize = 65;
        iconSize = 50;
        bar = 80;
        pad = 10;
        header = 0.07;
        heightMap = 0.70;
      });
    return Scaffold(
        backgroundColor: Colors.white,
        extendBody: true,
        appBar: AppBar(
          toolbarHeight: heightSize * header,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          actions: [
            IconButton(
              color: Color(0xff35a687),
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: new Icon(Icons.logout),
              onPressed: () {
                exit(0);
              },
            ),
            IconButton(
              color: Color(0xff35a687),
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: new Icon(Icons.close_fullscreen_rounded),
              onPressed: () {
                MoveToBackground.moveTaskToBack();
              },
            ),
          ],
          leading: Builder(builder: (context) {
            return IconButton(
              color: Color(0xff35a687),
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: new Icon(Icons.dehaze_rounded, size: iconSize),
              onPressed: () {
                draw.toggle();
              },
            );
          }),
        ),
        body: Container(
          margin: EdgeInsets.only(
            bottom: heightSize * 0.1,
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Divider(
                  height: 0.5,
                  color: Color(0xff002466),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      child: Text(
                          (icon != null)
                              ? "${AppLocalizations.of(context)!.translate('modeMsgB')}      ${AppLocalizations.of(context)!.translate(choice)}"
                              : "${AppLocalizations.of(context)!.translate('modeMsgA')}", //"$choice",
                          style: TextStyle(
                            color: Color(0xff002466),
                            fontFamily: 'poppins-Light',
                            fontSize: size,
                          )),
                    ),
                  ),
                  Container(
                      child: (icon != null)
                          ? Padding(
                              padding: applang == Locale('ar')
                                  ? EdgeInsets.only(right: 20)
                                  : EdgeInsets.only(left: 20),
                              child: Icon(icon, color: Color(0xff35a687)))
                          : null)
                ]),
                Divider(
                  color: Color(0xff002466),
                  height: 0.5,
                ),
                MapWidget(heightSize, widthSize, heightMap),
              ]),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: GestureDetector(
          onVerticalDragUpdate: DefaultBottomBarController.of(context).onDrag,
          onVerticalDragEnd: DefaultBottomBarController.of(context).onDragEnd,
          child: FloatingActionButton.extended(
              backgroundColor: Color(0xff35a687),
              isExtended: true,
              label: AnimatedBuilder(
                animation: DefaultBottomBarController.of(context).state,
                builder: (context, child) => Container(
                  width: widthSize * 0.80,
                  height: heightSize * 0.05,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "${AppLocalizations.of(context)!.translate(button)}",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'poppins-Light',
                          fontSize: 16),
                    ),
                  ),
                ),
              ),
              onPressed: () {
                setState(() {
                  DefaultBottomBarController.of(context).swap();
                });
              }),
        ),
        bottomNavigationBar: BottomExpandableAppBar(
            expandedHeight: heightSize * 0.5,
            appBarHeight: heightSize * 0.05,
            horizontalMargin: 16,
            shape: AutomaticNotchedShape(
                RoundedRectangleBorder(), StadiumBorder(side: BorderSide())),
            expandedBackColor: Colors.transparent,
            expandedBody: Center(
              child: GlassmorphicContainer(
                height: heightSize * 0.5 + heightSize * 0.05,
                width: widthSize * 0.95,
                borderRadius: 20,
                blur: 7,
                alignment: Alignment.bottomCenter,
                border: 1,
                linearGradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xff52B69A).withOpacity(0.09),
                      Color(0xff52B69A).withOpacity(0.1),
                    ],
                    stops: [
                      0.1,
                      1,
                    ]),
                borderGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.05),
                    Colors.white.withOpacity(0.5),
                  ],
                ),
                child: GetUserData(
                  documentId: uid!,
                  stateChnage: (int index, List<Elements> elements) {
                    setState(() {
                      size = 17;
                      button = "changeMode";
                      choice = elements[index].key;
                      icon = elements[index].icon;
                      DefaultBottomBarController.of(context).swap();
                    });
                  },
                  heightSize: heightSize,
                ),
              ),
            ),
            bottomAppBarBody: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: heightSize * 0.05,
              ),
            )));
  }
}
