import 'package:flutter/material.dart';
import 'package:my_app/features/Home/presentation/pages/userHome.dart';
import '../opening.dart';
import 'features/Stepper/presentation/pages/stepper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'features/Stepper/data/auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatefulWidget {
  @override
  MyApp createState() => MyApp();
}

class MyApp extends State<App> {
  final Future _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        // Replace the 3 second delay with your initialization code:
        future: Future.delayed(Duration(seconds: 3)),
        builder: (context, AsyncSnapshot snapshot) {
          // Show splash screen while waiting for app resources to load:
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
                debugShowCheckedModeBanner: false, home: Splash());
          } else {
            // Loading is done, return the app:
            return FutureBuilder(
                // Initialize FlutterFire:
                future: _initialization,
                builder: (context, snapshot) {
                  // Check for errors
                  if (snapshot.hasError) {
                    return Container();
                  }

                  // Once complete, show your application
                  else if (snapshot.connectionState == ConnectionState.done) {
                    final FirebaseAuth auth = FirebaseAuth.instance;
                    var user = auth.currentUser;

                    if (user != null) {
                      String uid = getUser(user)!.uid;
                      // this is your user instance
                      /// is because there is user already logged
                      return MaterialApp(
                          debugShowCheckedModeBanner: false,
                          home: UserHome(uid));
                    }

                    /// other way there is no user logged.
                    else {
                      return MaterialApp(
                        debugShowCheckedModeBanner: false,
                        home: Scaffold(body: new_user()),
                      );
                    }
                  }

                  return Container();
                });
          }
        });
  }
}
