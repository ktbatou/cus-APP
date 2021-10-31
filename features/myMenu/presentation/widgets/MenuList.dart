import 'package:flutter/material.dart';
import 'package:my_app/core/allChoices.dart';
import 'package:my_app/core/elements.dart';
import 'package:my_app/features/Stepper/data/database.dart';
import 'package:my_app/features/Stepper/data/list.dart';
import 'package:my_app/features/language/data/appLocalization.dart';
import 'package:my_app/features/language/data/provider/languageProvider.dart';
import 'package:my_app/features/myMenu/domain/usecases/ListState.dart';
import 'package:provider/provider.dart';

class MenuList extends StatefulWidget {
  var heightSize;
  var widthSize;
  bool clicked;
  String id;
  MenuList(
      {this.heightSize,
      required this.widthSize,
      required this.clicked,
      required this.id});

  @override
  _listState createState() {
    return _listState(heightSize: heightSize, widthSize: widthSize, uid: id);
  }
}

class _listState extends State<MenuList> {
  var heightSize;
  var widthSize;

  String uid;

  _listState({this.heightSize, required this.widthSize, required this.uid});

  bool get clicked => widget.clicked;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var appLang = Provider.of<AppLang>(context).fetchLocale();
    return Container(
      padding: EdgeInsets.only(
        top: heightSize * 0.03,
      ),
      child: ListView.separated(
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 1,
          );
        },
        itemCount: context.watch<ListState>().menuList.length,
        itemBuilder: (BuildContext context, int index) {
          return (!clicked &&
                  !context.watch<ListState>().menuList[index].selected)
              ? SizedBox()
              : Container(
                  padding: EdgeInsets.only(left: widthSize * 0.02),
                  child: ListTile(
                    title: Text(
                        "${AppLocalizations.of(context)!.translate(context.watch<ListState>().menuList[index].key)}",
                        style: TextStyle(
                          color: Color(0xff002466),
                          fontFamily: 'poppins-Light',
                          fontSize: 20,
                        )),
                    leading: Icon(
                      context.watch<ListState>().menuList[index].icon,
                      color: Color(0xff35a687), //s.black),
                    ),
                    trailing: clicked == true
                        ? ((context
                                    .watch<ListState>()
                                    .menuList[index]
                                    .selected ==
                                true)
                            ? IconButton(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                color: Colors.red,
                                icon: Icon(Icons.remove),
                                onPressed: () {
                                  Provider.of<ListState>(context, listen: false)
                                      .changeSelectedStatus(index, false);
                                },
                              )
                            : IconButton(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                color: Colors.blue,
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  Provider.of<ListState>(context, listen: false)
                                      .changeSelectedStatus(index, true);
                                }))
                        : null,
                  ),
                );
        },
      ),
    );
  }
}
