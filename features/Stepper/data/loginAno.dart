import 'package:firebase_auth/firebase_auth.dart';

class Login {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void signInAnonymously() {
    _auth.signInAnonymously();
  }
}
