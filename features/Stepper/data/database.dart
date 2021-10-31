import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import 'package:my_app/core/elements.dart';
import 'package:my_app/features/Home/presentation/data/repositories/Converter.dart';



class UserDatabase {
  final String uid;
  UserDatabase(this.uid);

  final firestoreInstance =
      FirebaseFirestore.instance.collection('modeOfTrans');
  Future transDoc(List selected) async {
    return await firestoreInstance.doc(uid).set({
      "choices": FieldValue.arrayUnion(selected),
    });
  }

  Future<void> UpdatetransDoc(List<Elements> selected) async {
    final selectedChoices =
        selected.where((choice) => choice.selected == true).toList();
    List<String> newList = selectedChoices.map((e) => e.key).toList();

    return await firestoreInstance.doc(uid).set({
      "choices": FieldValue.arrayUnion(newList),
    });
  }

  Future<List<Elements>> modeList() async {
    List choices = [];
    List<Elements> result;
    await firestoreInstance.doc(uid).get().then((value) {
      choices = value.data()!['choices'];
    });
    result = converter(choices);
    return result;
  }
}
