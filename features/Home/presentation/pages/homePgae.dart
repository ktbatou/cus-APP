import 'package:flutter/material.dart';
import '../../../map/presentation/widgets/map.dart';
import '../../../../core/elements.dart';
import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:glassmorphism/glassmorphism.dart';

import '../data/repositories/dataGetter.dart';

class Example extends StatefulWidget {
  final zoomDraw;

  String uid;

  Example(this.uid, this.zoomDraw);
  @override
  State<StatefulWidget> createState() => ExamplePage(uid: uid, draw: zoomDraw);
}

class ExamplePage extends State<StatefulWidget> {
  String? uid;
  String choice = "Vous n'avez pas encore choisir de mode!";
  String button = "Choisir un mode";
  double imageSize = 80;
  double iconSize = 40;
  double bar = 80;
  double pad = 20;
  double size = 15;
  IconData? icon;
  final draw;
  ExamplePage({this.uid, this.draw});

  @override
  Widget build(BuildContext context) {
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
    return Scaffold(
        backgroundColor: Colors.white,
        extendBody: true,
        appBar: AppBar(
          toolbarHeight: heightSize * 0.07,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
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
        //drawer: Drawer(child: Settings()),
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
                              ? "Mode actuel :      $choice"
                              : "$choice",
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
                              padding: EdgeInsets.only(left: 20),
                              child: Icon(icon, color: Color(0xff35a687)))
                          : null)
                ]),
                Divider(
                  color: Color(0xff002466),
                  height: 0.5,
                ),
                MapPage(heightSize, widthSize),
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
                    "$button",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'poppins-Light',
                        fontSize: 16),
                  ),
                ),
              ),
            ),
            onPressed: () => DefaultBottomBarController.of(context).swap(),
          ),
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
                      button = "Changer de mode";
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
