import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_app/features/Home/presentation/pages/ModeMenu.dart';
import '/../../../core/elements.dart';
import 'Converter.dart';
import 'dart:async';

class GetUserData extends StatelessWidget {
  final String documentId;
  final Function stateChnage;
  var heightSize;

  GetUserData(
      {required this.documentId, required this.stateChnage, this.heightSize});

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
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          List<Elements> choices = converter(data['choices']);
          return TransMenu(
            changeState: stateChnage,
            elems: choices,
            heightSize: heightSize,
          );
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
