import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_app/core/elements.dart';
import '/features/Stepper/data/list.dart';

List<Elements> converter(List choices) {
  List<String> mode = [];
  List<Elements> result;

  for (var x in choices) mode.add(x.toString());
  result = getList(mode);
  return result;
}
