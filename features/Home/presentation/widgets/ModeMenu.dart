import 'package:flutter/material.dart';
import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:my_app/features/Home/presentation/data/repositories/currentMode.dart';
import 'package:my_app/features/language/data/appLocalization.dart';
import 'package:my_app/features/language/data/provider/languageProvider.dart';
import 'package:provider/provider.dart';
import '../../../../core/elements.dart';

class TransMenu extends StatefulWidget {
  final Function changeState;
  var heightSize;
  List<Elements> elems;
  String id;
  TransMenu(
      {required this.changeState,
      required this.elems,
      this.heightSize,
      required this.id});

  @override
  _transMenuState createState() => _transMenuState(
      state: changeState, elements: elems, heightSize: heightSize, id: id);
}

class _transMenuState extends State<TransMenu> {
  var heightSize;
  List<Elements> elements;
  final Function state;
  String id;
  _transMenuState(
      {required this.state,
      required this.elements,
      this.heightSize,
      required this.id});

  @override
  Widget build(BuildContext context) {
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
                      title: Text(
                          "${AppLocalizations.of(context)!.translate(elements[index].key)}",
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
                        //TODO: get the id
                        registreMode().saveCurrentMode(id, elements[index].key);
                        widget.changeState(index, elements);
                      },
                    ),
                  ));
            }));
  }
}
