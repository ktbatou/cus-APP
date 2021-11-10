import 'package:flutter/material.dart';
import 'package:my_app/features/language/data/appLocalization.dart';
import 'package:my_app/features/language/data/provider/languageProvider.dart';
import 'package:my_app/features/language/presentation/pages/language.dart';
import 'package:my_app/features/myMenu/data/repositories/getMenu.dart';
import 'package:my_app/features/myMenu/presentation/pages/MyMenu.dart';
import 'package:provider/provider.dart';

class Setting extends StatefulWidget {
  String uid;
  Setting({required this.uid});
  @override
  State<StatefulWidget> createState() => _Setting(id: uid);
}

class _Setting extends State<Setting> {
  String id;
  _Setting({required this.id});
  @override
  Widget build(BuildContext context) {
    var applang = Provider.of<AppLang>(context).appLocal;
    double heightSize = MediaQuery.of(context).size.height;
    double widthSize = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.2, 0.65], //, 0.5, 0.9],
          colors: [
            Color((0xffF1F5F9)),
            Color(0xff52B69A).withOpacity(0.01),
            //  Color((0xffF1F5F9)),
            // Color(0xff52B69A).withOpacity(0.01),
          ],
        ),
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                //width: widthSize - (widthSize * 0.26),
                padding: applang == Locale('ar')
                    ? EdgeInsets.only(
                        top: 30, bottom: 10, left: widthSize * 0.2)
                    : EdgeInsets.only(
                        top: 30, bottom: 10, right: widthSize * 0.2),
                child: Image.asset(
                  'assets/images/um6pL.png',
                  width: 150,
                  height: 150,
                  alignment: Alignment.centerLeft,
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                width: widthSize - (widthSize * 0.26),
                child: ListView(
                  padding: const EdgeInsets.all(8),
                  children: <Widget>[
                    InkWell(
                      child: ListTile(
                          title: Text(
                              "${AppLocalizations.of(context)!.translate('mymodes')}",
                              style: TextStyle(
                                color: Color(0xff002466), //(0xff002466),
                                fontFamily: 'poppins-Light',
                                fontSize: 18,
                              )),
                          leading: Icon(Icons.emoji_transportation_outlined,
                              color: Color(0xff35a687))), //(0xff52B69A))),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyModes(uid: id),
                            ));
                      },
                    ),
                    InkWell(
                        child: ListTile(
                            title: Text(
                                "${AppLocalizations.of(context)!.translate('language')}",
                                style: TextStyle(
                                  color: Color(0xff002466), //(0xff002466),
                                  fontFamily: 'poppins-Light',
                                  fontSize: 18,
                                )),
                            leading: Icon(Icons.language,
                                color: Color(
                                    0xff35a687))), //s.black)), //(0xff52B69A))),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AppLanguage(uid: id),
                              ));
                        }),
                    InkWell(
                        child: ListTile(
                            title: Text(
                                "${AppLocalizations.of(context)!.translate('instractions')}",
                                style: TextStyle(
                                  color: Color(0xff002466), //(0xff002466),
                                  fontFamily: 'poppins-Light',
                                  fontSize: 18,
                                )),
                            leading: Icon(Icons.menu_book,
                                color: Color(0xff35a687))), //(0xff52B69A)),

                        onTap: () {}),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Divider(color: Colors.black12 //(0xff2374AB),
                  ),
            ),
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Container(
                padding: EdgeInsets.only(bottom: 20),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                      "${AppLocalizations.of(context)!.translate('about')}",
                      style: TextStyle(
                        color: Color(0xff002466), //(0xff002466),
                        fontFamily: 'poppins-Light',
                        fontSize: 15,
                      )),
                ),
              ),
              onTap: () {},
            )
          ]),
    );
  }
}
