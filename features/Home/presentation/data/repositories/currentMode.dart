import 'package:cloud_firestore/cloud_firestore.dart';

class registreMode {
  void saveCurrentMode(String id, String mode) {
    FirebaseFirestore.instance.collection('trips').doc(id).set({
      'Used Mode': {
        '${DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)}':
            {
          '${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}':
              mode,
        },
      }
    }, SetOptions(merge: true));
  }
}
