import 'package:flutter/material.dart';
import 'package:my_app/core/elements.dart';
import 'package:my_app/features/Home/presentation/widgets/ModeMenu.dart';
import 'package:my_app/features/myMenu/data/repositories/getMenu.dart';

class MyModes extends StatefulWidget {
  String uid;

  MyModes({required this.uid});
  @override
  _MyModesState createState() => _MyModesState(uid: uid);
}

class _MyModesState extends State<MyModes> {
  String uid;

  _MyModesState({required this.uid});
  var left = 0.02;
  var right = 0.025;
  double top = 0;
  @override
  Widget build(BuildContext context) {
    double heightSize = MediaQuery.of(context).size.height;
    double WidthtSize = MediaQuery.of(context).size.width;
    if (MediaQuery.of(context).size.width > 600) {
      left = 0.01;
      right = left;
      top = 0.02;
    } else {
      left = 0.02;
      right = 0.025;
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          toolbarHeight: heightSize * 0.1,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          actions: [
            Align(
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.only(right: 29),
                  child: Text(
                    "Edit",
                    style: TextStyle(color: Color(0xff35A687), fontSize: 20),
                  ),
                )),
          ],
          leading: Container(
              height: 10,
              width: 10,
              padding: EdgeInsets.only(
                //TODO: when there is rottaion left & right : 0.01 ... top 0.02
                left: WidthtSize * left,
                right: WidthtSize * right,
              ),
              child: CircleAvatar(
                  backgroundColor: Color(0xff35A687),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )))),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              //  padding: EdgeInsets.only(top: heightSize * 0.01),
              child: Align(
                  alignment: Alignment.center,
                  child: Text("Mes Modes de Transport",
                      style: TextStyle(
                        color: Color(0xff002466),
                        fontFamily: 'poppins-Light',
                        fontSize: 20,
                      )))),
          Expanded(
            child: GetMenu(
              documentId: uid,
              HeightSize: heightSize,
              widthSize: WidthtSize,
            ),
          ),
        ],
      ),
    );
  }
}
