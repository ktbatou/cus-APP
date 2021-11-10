import 'package:flutter/material.dart';
import 'package:my_app/features/Home/presentation/pages/homePgae.dart';
import 'package:my_app/features/Stepper/presentation/pages/stepper.dart';
import 'package:my_app/features/language/data/appLocalization.dart';
import 'package:my_app/features/language/data/provider/languageProvider.dart';
import 'package:my_app/features/language/presentation/widgets/languageObj.dart';
import 'package:my_app/features/myMenu/presentation/pages/MyMenu.dart';
import 'package:provider/provider.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';

class AppLanguage extends StatefulWidget {
  String uid;
  AppLanguage({required this.uid});
  @override
  _AppLanguageState createState() => _AppLanguageState(id: uid);
}

class _AppLanguageState extends State<AppLanguage> {
  String id;
  _AppLanguageState({required this.id});
  var left = 0.02;
  var right = 0.025;
  double top = 0;
  double size = 0.06;
  List<IconLangue> LangIcon = [
    IconLangue(
        language: "english",
        img: "assets/images/uk.png",
        choosen: false,
        local: "en"),
    IconLangue(
        language: "french",
        img: "assets/images/fr.png",
        choosen: false,
        local: "fr"),
    IconLangue(
        language: "arabic",
        img: "assets/images/ar2.png",
        choosen: false,
        local: "ar"),
  ];

  List<IconLangue> selectedLang(var local, List<IconLangue> listLang) {
    listLang.forEach((element) {
      if (local == Locale(element.local)) {
        element.choosen = true;
      }
    });
    return listLang;
  }

  @override
  Widget build(BuildContext context) {
    var appLang = Provider.of<AppLang>(context).appLocal;
    LangIcon = selectedLang(appLang, LangIcon);
    double heightSize = MediaQuery.of(context).size.height;
    double WidthtSize = MediaQuery.of(context).size.width;
    if (MediaQuery.of(context).size.width > 600) {
      left = 0.01;
      right = left;
      top = 0.02;
      size = 0.1;
    } else {
      left = 0.02;
      right = 0.025;
      size = 0.06;
    }
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            toolbarHeight: heightSize * 0.1,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
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
                          "${AppLocalizations.of(context)!.translate('language')}",
                          style: TextStyle(
                            color: Color(0xff002466),
                            fontFamily: 'poppins-Light',
                            fontSize: 24,
                          )))),
              Expanded(
                  child: Align(
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.only(top: heightSize * 0.10),
                  width: WidthtSize * 0.81,
                  child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 10,
                        );
                      },
                      itemCount: LangIcon.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Material(
                          color: Colors.transparent,
                          child: InkWell(
                              child: Container(
                                height: heightSize * size,
                                decoration: BoxDecoration(
                                  color:
                                      Locale(LangIcon[index].local) == appLang
                                          ? Color(0xff35A687)
                                          : Colors.white,
                                  borderRadius: BorderRadius.circular(20.0),
                                  border: Border.all(
                                    color:
                                        Locale(LangIcon[index].local) == appLang
                                            ? Color(0xff35A687)
                                            : Colors.grey,
                                  ),
                                  boxShadow:
                                      Locale(LangIcon[index].local) == appLang
                                          ? [
                                              BoxShadow(
                                                color: Color(0xffDE6FC0AA),
                                                blurRadius: 4,
                                                offset: Offset(2, 2),
                                              )
                                            ]
                                          : null,
                                ),
                                child: Row(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  // mainAxisAlignment:
                                  //  MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          /*  padding: appLang == Locale('ar')
                                                ? EdgeInsets.only(
                                                    right: WidthtSize * 0.03)
                                                : EdgeInsets.only(
                                                    left: WidthtSize * 0.03),*/
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Image.asset(
                                              LangIcon[index].img,
                                              width: WidthtSize * 0.07,
                                              height: WidthtSize * 0.07,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Container(
                                            /*  padding: appLang == Locale('ar')
                                                  ? EdgeInsets.only(
                                                      right: WidthtSize * 0.2)
                                                  : EdgeInsets.only(
                                                      left: WidthtSize * 0.2),*/
                                            //   EdgeInsets.only(top: heightSize * 0.01),
                                            child: Text(
                                                "${AppLocalizations.of(context)!.translate(LangIcon[index].language)}",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Locale(LangIcon[index]
                                                              .local) ==
                                                          appLang
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontFamily: 'poppins-Light',
                                                  fontSize: 18,
                                                ))),
                                      ),
                                    ),
                                    Spacer(),
                                  ],
                                ),
                              ),
                              onTap: () {
                                if (LangIcon[index].local !=
                                    appLang.toString()) {
                                  Dialogs.materialDialog(
                                      msg:
                                          '${AppLocalizations.of(context)!.translate('langmsg')}',
                                      title:
                                          "${AppLocalizations.of(context)!.translate('lantitle')}",
                                      color: Colors.white,
                                      context: context,
                                      actions: [
                                        IconsOutlineButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          text:
                                              '${AppLocalizations.of(context)!.translate('cancel')}',
                                          iconData: Icons.cancel_outlined,
                                          textStyle:
                                              TextStyle(color: Colors.grey),
                                          iconColor: Colors.grey,
                                        ),
                                        IconsButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            if (LangIcon[index].language ==
                                                "french") {
                                              Provider.of<AppLang>(context,
                                                      listen: false)
                                                  .changeLanguage(
                                                      Locale('fr', ''));
                                            } else if (LangIcon[index]
                                                    .language ==
                                                "arabic")
                                              Provider.of<AppLang>(context,
                                                      listen: false)
                                                  .changeLanguage(
                                                      Locale('ar', ''));
                                            else
                                              Provider.of<AppLang>(context,
                                                      listen: false)
                                                  .changeLanguage(
                                                      Locale('en', ''));
                                          },
                                          text:
                                              '${AppLocalizations.of(context)!.translate('yes')}',
                                          iconData: Icons.check,
                                          color: Color(0xff35A687),
                                          textStyle:
                                              TextStyle(color: Colors.white),
                                          iconColor: Colors.white,
                                        ),
                                      ]);
                                }
                              }),
                        );
                      }),
                ),
              )),
            ]));
  }
}
