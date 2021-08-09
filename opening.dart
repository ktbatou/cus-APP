import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Splash();
}

class _Splash extends State<Splash> with SingleTickerProviderStateMixin {
  Animation? animation;
  AnimationController? animationController;
  double imageSize = 200;
  double font = 20;

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController!, curve: Curves.fastOutSlowIn));
    animationController!.forward();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width > 600 &&
        MediaQuery.of(context).size.height > 500) {
      imageSize = 300;
      font = 30;
    } else {
      imageSize = 200;
      font = 20;
    }
    return Scaffold(
        backgroundColor: Color(0xffF1F5F9),
        body: FadeTransition(
          opacity:
              animationController!.drive(CurveTween(curve: Curves.easeOut)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/um6pL.png',
                    width: imageSize,
                    height: imageSize,
                  ),
                ),
              ),
              Container(
                  padding: EdgeInsets.only(top: 30),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Color(0xff52B69A)),
                    ),
                  ))
            ],
          ),
        ));
  }
}
