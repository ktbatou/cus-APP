import 'package:flutter/material.dart';

class Act extends StatefulWidget {
  double wid;
  double heig;
  VoidCallback? Continue;
  VoidCallback? cancel;
  Act(this.wid, this.heig, this.cancel, this.Continue);
  @override
  State<StatefulWidget> createState() => Actions(wid, heig, cancel!, Continue!);
}

class Actions extends State<Act> {
  double widthSize;
  double heightSize;
  VoidCallback onStepContinue;
  VoidCallback onStepCancel;
  Actions(
      this.widthSize, this.heightSize, this.onStepCancel, this.onStepContinue);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: heightSize * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: heightSize * 0.05,
            width: widthSize * 0.3,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            child: TextButton(
              onPressed: onStepCancel,
              child: const Text(
                'Annuler',
                style: TextStyle(color: Colors.black54),
              ),
            ),
          ),
          new Padding(
            padding: new EdgeInsets.all(10),
          ),
          Container(
            height: heightSize * 0.05,
            width: widthSize * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
              color: Color(0xff3AB795),
            ),
            child: TextButton(
              onPressed: onStepContinue,
              child: const Text('Continuer',
                  style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
