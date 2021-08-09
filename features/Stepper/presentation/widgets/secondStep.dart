import 'package:flutter/material.dart';
import 'package:my_app/core/elements.dart';

class Second extends StatefulWidget {
  double wid;
  double heig;
  List<Elements> elem;
  Color Col;
  Second(this.elem, this.heig, this.wid, this.Col);
  @override
  State<StatefulWidget> createState() => Steptwo(elem, heig, wid, Col);
}

class Steptwo extends State<Second> {
  double widthSize;
  double heightSize;
  List<Elements> choices;
  Color cooler;
  Steptwo(this.choices, this.heightSize, this.widthSize, this.cooler);
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          child: Align(
              alignment: Alignment.center,
              child: Text(
                  "Veuillez préciser les modes de transport que vous utilisez habituellement",
                  style: TextStyle(
                    fontFamily: 'poppins-Light',
                    fontSize: 16,
                  )))),
      Container(
        padding: EdgeInsets.only(top: 20),
        height: heightSize * 0.5,
        width: widthSize * 0.8,
        child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 8,
              );
            },
            itemCount: choices.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  color: cooler,
                ),
                height: 56,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Icon(
                          choices[index].icon,
                          color: Colors.black54,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Text("${choices[index].key}",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'poppins-Light',
                              fontSize: 18,
                            )),
                      ),
                    ]),
                    Theme(
                      data: ThemeData(
                        unselectedWidgetColor: Colors.black54,
                      ),
                      child: Checkbox(
                        activeColor: Color(0xffF1F5F9),
                        checkColor: Color(0xff2b3a67),
                        shape: CircleBorder(),
                        value: choices[index].selected,
                        onChanged: (bool? value) {
                          setState(() {
                            choices[index].selected = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    ]);
  }
}
