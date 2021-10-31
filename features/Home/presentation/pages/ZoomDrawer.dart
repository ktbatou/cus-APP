import 'package:flutter/material.dart';
import 'package:my_app/features/Home/presentation/widgets/drwer.dart';
import 'package:my_app/features/language/data/provider/languageProvider.dart';
import 'package:provider/provider.dart';
import 'homePgae.dart';
import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class ZoomDraw extends StatefulWidget {
  String uid;
  ZoomDraw(this.uid);

  @override
  State<StatefulWidget> createState() => ZoomDrawState(uid);
}

class ZoomDrawState extends State<StatefulWidget> {
  String uid;
  ZoomDrawState(this.uid);
  @override
 

  @override
  Widget build(BuildContext context) {
    var local = Provider.of<AppLang>(context).appLocal;
    print(local);
    final _drawerController = ZoomDrawerController();
    return Scaffold(
        body: ZoomDrawer(
      controller: _drawerController,
      menuScreen: Setting(
        uid: uid,
      ),
      mainScreen:
          DefaultBottomBarController(child: Home(uid, _drawerController)),
      borderRadius: 24.0,
      showShadow: true,
      angle: 0.0,
      mainScreenScale: 0.2,
      slideWidth: MediaQuery.of(context).size.width *
          (local.toString() == "ar" ? -0.64 : 0.64),
    ));
  }
}
