import 'package:firebase_auth/firebase_auth.dart';

class CustomUser {
  final String uid;
  CustomUser({required this.uid});
}

CustomUser? getUser(User user) {
  return user != null ? CustomUser(uid: user.uid) : null;
}

Future signInAnonymous() async {
  try {
    UserCredential result = await FirebaseAuth.instance.signInAnonymously();
    User? user = result.user;
    return getUser(user!);
  } catch (e) {
    print(e.toString());
    return null;
  }
}
