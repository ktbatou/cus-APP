import 'package:flutter/material.dart';
import 'package:my_app/core/elements.dart';
import 'package:my_app/core/allChoices.dart';
import 'package:my_app/features/Stepper/presentation/widgets/thirdStep.dart';
import 'dart:io';
import '../../../Home/presentation/pages/ZoomDrawer.dart';
import '../widgets/firstStep.dart';
import '../widgets/secondStep.dart';
import '../widgets/actions.dart';
import '../widgets/thirdStep.dart';
import '../../data/auth.dart';
import '../../data/database.dart';

class new_user extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => New();
}

class New extends State<new_user> {
  double imageSize = 80;
  double iconSize = 40;
  double bar = 80;
  double pad = 20;
  dynamic result;
  double buttonHeight = 0.05;

  List<Elements> choices = AllChoices();
  int _currentStep = 0;
  var stepperType = StepperType.vertical;
  @override
  Widget build(BuildContext context) {
    double widthSize = MediaQuery.of(context).size.width;
    double heightSize = MediaQuery.of(context).size.height;
    if (MediaQuery.of(context).size.width <
        MediaQuery.of(context).size.height) {
      setState(() {
        imageSize = 100;
        iconSize = 60;
        bar = 100;
        pad = 35;
        buttonHeight = 0.07;
      });
    } else {
      setState(() {
        imageSize = 65;
        iconSize = 40;
        bar = 80;
        pad = 10;
        buttonHeight = 0.05;
      });
    }
    Color cooler = Color(0xff35a687).withOpacity(0.8);
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.2, 0.65],
            colors: [
              Color((0xffF1F5F9)),
              Color(0xff52B69A).withOpacity(0.01),
            ],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            padding: EdgeInsets.only(top: heightSize * 0.05),
            child: Column(
              children: [
                Expanded(
                  child: Theme(
                    data: ThemeData(
                        colorScheme:
                            ColorScheme.light(primary: Color(0xff3AB795))),
                    child: Stepper(
                      type: stepperType,
                      physics: ScrollPhysics(),
                      currentStep: _currentStep,
                      onStepTapped: (step) => tapped(step),
                      onStepCancel: cancel,
                      onStepContinue: continued,
                      controlsBuilder: (BuildContext context,
                          {VoidCallback? onStepContinue,
                          VoidCallback? onStepCancel}) {
                        return Act(widthSize, heightSize, onStepCancel,
                            onStepContinue, buttonHeight);
                      },
                      steps: <Step>[
                        Step(
                          title: new Text(
                            'Bienvenue',
                            style: TextStyle(fontSize: 20),
                          ),
                          content: First(),
                          isActive: _currentStep >= 0,
                          state: _currentStep >= 0
                              ? StepState.complete
                              : StepState.disabled,
                        ),
                        Step(
                          title: new Text(
                            'Modes de transport',
                            style: TextStyle(fontSize: 20),
                          ),
                          content:
                              Second(choices, heightSize, widthSize, cooler),
                          isActive: _currentStep >= 0,
                          state: _currentStep >= 1
                              ? StepState.complete
                              : StepState.disabled,
                        ),
                        Step(
                          title: Text(
                            'Accomplie',
                            style: TextStyle(fontSize: 20),
                          ),
                          content: Third(),
                          isActive: _currentStep >= 0,
                          state: _currentStep >= 2
                              ? StepState.complete
                              : StepState.disabled,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() async {
    final selectedChoices =
        choices.where((choice) => choice.selected == true).toList();

    if (_currentStep == 0) {
      //TODO: error management if the login went off

      result = await signInAnonymous();
      //    print(result.uid);

      if (result == null) {
        print('error signing in');
      } else {
        print('sign in ');

        // UserDatabase(result.uid).transDoc(["test1"]);
      }
      _currentStep < 2 ? setState(() => _currentStep += 1) : null;
    } else if (_currentStep == 1) {
      final snackBar = SnackBar(
          content: Text(
            'Veuillez sélectionner au moins un choix\n',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
          duration: Duration(seconds: 2));

      if (selectedChoices.isEmpty)
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      else {
        List<String> choices = selectedChoices.map((e) => e.key).toList();
        //  print(choices);
        await UserDatabase(result.uid).transDoc(choices);

        _currentStep < 2 ? setState(() => _currentStep += 1) : null;
      }
    } else if (_currentStep == 2) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => ZoomDraw(result.uid)),
          (Route<dynamic> route) => false);
    } else
      _currentStep < 2 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    if (_currentStep == 0) {
      exit(0);
    }
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }
}
