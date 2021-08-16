import 'package:firebase_auth/firebase_auth.dart';

void signInAnonymously() {
  try {
    final Future<UserCredential> _auth =
        FirebaseAuth.instance.signInAnonymously();
    print("logged in");
  } catch (e) {
    print("Error == >${e.toString()})");
  }
}
