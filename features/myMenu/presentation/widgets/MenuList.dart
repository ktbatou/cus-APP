import 'package:flutter/material.dart';
import 'package:my_app/core/elements.dart';

class MenuList extends StatefulWidget {
  var heightSize;
  var widthSize;
  List<Elements> elems;
  MenuList({required this.elems, this.heightSize, required this.widthSize});

  @override
  _listState createState() =>
      _listState(elements: elems, heightSize: heightSize, widthSize: widthSize);
}

class _listState extends State<MenuList> {
  var heightSize;
  var widthSize;

  List<Elements> elements;

  _listState(
      {required this.elements, this.heightSize, required this.widthSize});
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
            itemCount: elements.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: EdgeInsets.only(left: widthSize * 0.02),
                child: ListTile(
                  title: Text("${elements[index].key}",
                      style: TextStyle(
                        color: Color(0xff002466),
                        fontFamily: 'poppins-Light',
                        fontSize: 20,
                      )),
                  leading: Icon(
                    elements[index].icon,
                    color: Color(0xff35a687), //s.black),
                  ),
                ),
              );
            }));
  }
}