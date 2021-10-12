import 'package:flutter/material.dart';
import 'package:my_app/core/allChoices.dart';
import 'package:my_app/core/elements.dart';
import 'package:my_app/features/Stepper/data/database.dart';
import 'package:my_app/features/Stepper/data/list.dart';

class MenuList extends StatefulWidget {
  var heightSize;
  var widthSize;
  List<Elements> elems;
  bool clicked;
  String id;
  MenuList(
      {required this.elems,
      this.heightSize,
      required this.widthSize,
      required this.clicked,
      required this.id});

  @override
  _listState createState() => _listState(
      choosen: elems,
      heightSize: heightSize,
      widthSize: widthSize,
      clicked: clicked,
      uid: id);
}

class _listState extends State<MenuList> {
  var heightSize;
  var widthSize;
  bool clicked;
  List<Elements> choosen;
  String uid;
  late List<Elements> _allChoices;

  _listState(
      {required this.choosen,
      this.heightSize,
      required this.widthSize,
      required this.clicked,
      required this.uid});

  @override
  void initState() {
    super.initState();
    _allChoices = mergedList(choosen);
  }

  void display(var list) {
    for (Elements e in list) print("Object: ${e.selected}, ${e.key}");
  }

  @override
  Widget build(BuildContext context) {
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
            itemCount: _allChoices.length,
            itemBuilder: (BuildContext context, int index) {
              return (!clicked && !_allChoices[index].selected)
                  ? SizedBox()
                  : Container(
                      padding: EdgeInsets.only(left: widthSize * 0.02),
                      child: ListTile(
                        title: Text("${(_allChoices[index].key)}",
                            style: TextStyle(
                              color: Color(0xff002466),
                              fontFamily: 'poppins-Light',
                              fontSize: 20,
                            )),
                        leading: Icon(
                          _allChoices[index].icon,
                          color: Color(0xff35a687), //s.black),
                        ),
                        trailing: clicked == true
                            ? ((_allChoices[index].selected == true)
                                ? IconButton(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    color: Colors.red,
                                    icon: Icon(Icons.remove),
                                    onPressed: () {
                                      setState(() {
                                        _allChoices[index].selected = false;
                                      });
                                    },
                                  )
                                : IconButton(
                                    color: Colors.blue,
                                    icon: Icon(Icons.add),
                                    onPressed: () {
                                      print(index);
                                      setState(() {
                                        _allChoices[index].selected = true;
                                      });
                                    }))
                            : null,
                      ),
                    );
            }));
  }
}
