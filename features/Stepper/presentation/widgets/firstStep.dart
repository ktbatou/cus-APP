import 'package:flutter/material.dart';

class First extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StepOne();
}

class StepOne extends State<First> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          Container(
            padding: EdgeInsets.only(bottom: 10),
            child: Image.asset(
              'assets/images/um6pL.png',
              width: 150,
              height: 150,
              alignment: Alignment.centerLeft,
            ),
          ),
          Align(
              alignment: Alignment.center,
              child: Text("Bienvenue sur l'application",
                  style: TextStyle(
                    // color: Color(0xff324B8A),
                    fontFamily: 'SerifCaption',
                    fontSize: 17,
                  ))),
          Container(
              padding: EdgeInsets.only(top: 3),
                                             child: Align(
                  alignment: Alignment.center,
                  child: Text("(Nom)",
                      style: TextStyle(
                        //   color: Color(0xff324B8A),
                        fontFamily: 'SerifCaption',
                        fontSize: 17,
                      )))),
          Container(
              padding: EdgeInsets.only(top: 10),
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                      "Cette application sera suivre vos modes de transport que vous utilisez quotidiennement.",
                      style: TextStyle(
                        color: Colors.black87,
                        fontFamily: 'poppins-Light',
                        fontSize: 14,
                      )))),
        ]));
  }
}
