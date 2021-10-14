import 'package:flutter/material.dart';
import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import '../../../../core/elements.dart';

class TransMenu extends StatefulWidget {
  final Function changeState;
  var heightSize;
  List<Elements> elems;
  TransMenu({required this.changeState, required this.elems, this.heightSize});

  @override
  _transMenuState createState() => _transMenuState(
      state: changeState, elements: elems, heightSize: heightSize);
}

class _transMenuState extends State<TransMenu> {
  var heightSize;
  List<Elements> elements;
  final Function state;
  _transMenuState(
      {required this.state, required this.elements, this.heightSize});

  @override
  Widget build(BuildContext context) {
    print(elements);
    return Container(
        padding: EdgeInsets.only(
          top: heightSize * 0.05,
        ),
        child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 10,
              );
            },
            itemCount: elements.length,
            itemBuilder: (BuildContext context, int index) {
              return Material(
                  color: Colors.transparent,
                  child: InkWell(
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
                      onTap: () {
                        widget.changeState(index, elements);
                      },
                    ),
                  ));
            }));
  }
}
