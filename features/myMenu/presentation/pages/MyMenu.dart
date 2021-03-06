import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_app/core/allChoices.dart';
import 'package:my_app/core/elements.dart';
import 'package:my_app/features/Home/presentation/data/repositories/Converter.dart';
import 'package:my_app/features/Home/presentation/widgets/ModeMenu.dart';
import 'package:my_app/features/Stepper/data/list.dart';
import 'package:my_app/features/language/data/appLocalization.dart';
import 'package:my_app/features/language/data/provider/languageProvider.dart';
import 'package:my_app/features/myMenu/data/repositories/getMenu.dart';
import 'package:my_app/features/myMenu/domain/usecases/ListState.dart';
import 'package:my_app/features/myMenu/presentation/widgets/MenuList.dart';
import 'package:my_app/features/Stepper/data/database.dart';
import 'package:provider/provider.dart';

class MyModes extends StatefulWidget {
  String uid;

  MyModes({required this.uid});
  @override
  _MyModesState createState() => _MyModesState(uid: uid);
}

class _MyModesState extends State<MyModes> {
  String uid;
  Map<String, dynamic>? data;
  List<Elements>? choices;

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() async {
    data = await FirebaseFirestore.instance
        .collection('modeOfTrans')
        .doc(uid)
        .get()
        .then((value) => value.data());

    choices = converter(data!['choices']);
    choices = mergedList(choices!);
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Provider.of<ListState>(context, listen: false).addToMenuList(choices!);
    });
  }

  _MyModesState({required this.uid});
  var left = 0.02;
  var right = 0.025;
  double top = 0;
  String action = "edit";
  bool clicked = false;
  List<Elements> choicesList = AllChoices();
  @override
  Widget build(BuildContext context) {
    double heightSize = MediaQuery.of(context).size.height;
    double WidthtSize = MediaQuery.of(context).size.width;
    if (MediaQuery.of(context).size.width >
        MediaQuery.of(context).size.height) {
      left = 0.01;
      right = left;
      top = 0.02;
    } else {
      left = 0.02;
      right = 0.025;
    }
    void changer() async {
      setState(() {
        clicked = !clicked;
        if (clicked == true) {
          action = "done";
        } else {
          action = "edit";
        }
      });
      if (clicked == false) {
        await UserDatabase(uid).UpdatetransDoc(
            Provider.of<ListState>(context, listen: false).menuList);
      }
    }

    var appLang = Provider.of<AppLang>(context).appLocal;

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
                  padding: appLang == Locale('ar')
                      ? EdgeInsets.only(left: 29)
                      : EdgeInsets.only(right: 29),
                  child: Material(
                    child: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      child: Text(
                        //TODO: if clicked change Edit To Done & a boolean true if clicked
                        '${AppLocalizations.of(context)!.translate(action)}',
                        style:
                            TextStyle(color: Color(0xff35A687), fontSize: 20),
                      ),
                      onTap: () {
                        //final userList = Provider.of<ListState>(context);
                        //userList.MenuList = choicesList;
                        changer();
                      },
                    ),
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
                  child: Text(
                      "${AppLocalizations.of(context)!.translate('mymodes')}",
                      style: TextStyle(
                        color: Color(0xff002466),
                        fontFamily: 'poppins-Light',
                        fontSize: 20,
                      )))),
          /* choices == null
              ? Expanded(
                  child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        padding: EdgeInsets.only(top: 30),
                        child: CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              Color(0xff52B69A)),
                        ),
                      )),
                )
              :*/
          Expanded(
            child: MenuList(
              heightSize: heightSize,
              widthSize: WidthtSize,
              clicked: clicked,
              id: uid,
            ),
          )
        ],
      ),
    );
  }
}
