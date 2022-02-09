import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_app/features/Home/presentation/pages/ZoomDrawer.dart';
import 'package:my_app/features/language/data/appLocalization.dart';
import 'package:my_app/features/map/domain/usecases/LocationProvider.dart';
import 'package:my_app/features/myMenu/domain/usecases/ListState.dart';
import 'package:provider/provider.dart';
import '../opening.dart';
import 'features/Stepper/presentation/pages/stepper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'features/Stepper/data/auth.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'features/language/data/provider/languageProvider.dart';
import 'package:responsive_framework/responsive_framework.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppLang appLangue = AppLang();
  await appLangue.fetchLocale();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ListState()),
        ChangeNotifierProvider(
          create: (context) => LocationProvider(),
        ),
        ChangeNotifierProvider(create: (context) => appLangue),
      ],
      child: App(),
    ),
  );
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
              debugShowCheckedModeBanner: false,
              home: Splash(),
            );
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
                      print("==============> This is user $uid");

                      // this is your user instance
                      /// is because there is user already logged
                      return Consumer<AppLang>(builder: (context, model, _) {
                        return MaterialApp(
                            locale: model.appLocal,
                            supportedLocales: [
                              Locale('en', ''),
                              Locale('fr', ''),
                              Locale('ar', '')
                            ],
                            localizationsDelegates: [
                              AppLocalizations.delegate,
                              GlobalMaterialLocalizations.delegate,
                              GlobalWidgetsLocalizations.delegate,
                            ],
                            builder: (context, widget) =>
                                ResponsiveWrapper.builder(
                                  BouncingScrollWrapper.builder(
                                      context, widget!),
                                  maxWidth: 1200,
                                  minWidth: 480,
                                  defaultScale: true,
                                  breakpoints: [
                                    ResponsiveBreakpoint.resize(480,
                                        name: MOBILE),
                                    ResponsiveBreakpoint.autoScale(800,
                                        name: TABLET),
                                    ResponsiveBreakpoint.resize(1000,
                                        name: DESKTOP),
                                  ],
                                ),
                            debugShowCheckedModeBanner: false,
                            home: ZoomDraw(uid));
                      });
                    }

                    /// other way there is no user logged.
                    else {
                      return Consumer<AppLang>(builder: (context, model, _) {
                        return MaterialApp(
                          locale: model.appLocal,
                          supportedLocales: [
                            Locale('en', ''),
                            Locale('fr', ''),
                            Locale('ar', '')
                          ],
                          localizationsDelegates: [
                            AppLocalizations.delegate,
                            GlobalMaterialLocalizations.delegate,
                            GlobalWidgetsLocalizations.delegate,
                          ],
                          debugShowCheckedModeBanner: false,
                          home: Scaffold(body: new_user()),
                        );
                      });
                    }
                  }

                  return Container();
                });
          }
        });
  }
}
