import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_app/features/Stepper/data/list.dart';
import 'package:my_app/features/myMenu/presentation/state/ListState.dart';
import 'package:my_app/features/myMenu/presentation/widgets/MenuList.dart';
import '/../../../core/elements.dart';
import 'package:my_app/features/Home/presentation/data/repositories/Converter.dart';
import '../../presentation/pages/MyMenu.dart';
import 'dart:async';
import 'package:provider/provider.dart';

class GetMenu extends StatelessWidget {
  String documentId;
  double HeightSize;
  var widthSize;
  bool clicked;

  GetMenu({
    required this.documentId,
    required this.HeightSize,
    required this.widthSize,
    required this.clicked,
  });

  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('modeOfTrans');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          
          return MenuList(
              heightSize: HeightSize,
              widthSize: widthSize,
              clicked: clicked,
              id: documentId,);
        }

        return Container(
            padding: EdgeInsets.only(top: 30),
            child: Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                valueColor:
                    new AlwaysStoppedAnimation<Color>(Color(0xff52B69A)),
              ),
            ));
      },
    );
  }
}
