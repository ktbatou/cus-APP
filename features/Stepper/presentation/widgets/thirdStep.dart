import 'package:flutter/material.dart';

class Third extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StepThree();
}

class StepThree extends State<Third> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 3),
        child: Align(
            alignment: Alignment.center,
            child: Text(
                "tout est configuré avec succès, cliquez sur continuer pour commencer à utiliser l'application",
                style: TextStyle(
                  color: Colors.black87,
                  fontFamily: 'poppins-Light',
                  fontSize: 14,
                ))));
  }
}
