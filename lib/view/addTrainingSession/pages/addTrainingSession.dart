import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interval_timer_app/utils/colors.dart';
import 'package:interval_timer_app/utils/loader.dart';
import 'package:interval_timer_app/utils/sizeConfig.dart';
import 'package:interval_timer_app/utils/styles.dart';
import 'package:interval_timer_app/view/addTrainingSession/widgets/formField.dart';
import 'package:interval_timer_app/view/homepage/pages/homepage.dart';
import 'package:interval_timer_app/viewModel/trainingSession/trainingSession.dart';

class AddTrainingSession extends StatefulWidget {
  @override
  _AddTrainingSessionState createState() => _AddTrainingSessionState();
}

class _AddTrainingSessionState extends State<AddTrainingSession> {
  final _newTSKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _roundsController = TextEditingController();
  final TextEditingController _trainingDuration = TextEditingController();
  final TextEditingController _breakDuration = TextEditingController();

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text(
                "New training session",
              ),
              backgroundColor: secondaryTheme,
            ),
            body: Form(
              key: _newTSKey,
              child: Container(
                height: SizeConfig.blockSizeVertical * 100,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 20,
                      ),
                      NewSessionFormField(
                        labelText: "Enter a title",
                        hintText: "e.g. for jumping jacks...",
                        inputType: TextInputType.text,
                        fieldController: _titleController,
                      ),
                      NewSessionFormField(
                        labelText: "Enter a number of rounds: ",
                        fieldController: _roundsController,
                        atLeast: 2,
                      ),
                      NewSessionFormField(
                        labelText:
                            "Enter a duration of training interval (in seconds): ",
                        fieldController: _trainingDuration,
                        atLeast: 5,
                      ),
                      NewSessionFormField(
                        labelText:
                            "Enter a duration of break interval (in seconds): ",
                        fieldController: _breakDuration,
                        atLeast: 5,
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 3,
                      ),
                      Center(
                        child: RaisedButton(
                          onPressed: () {
                            if (_newTSKey.currentState.validate()) {
                              setState(() {
                                loading = true;
                              });
                              TrainingSession().addNewTrainingSession(
                                  _titleController.text,
                                  _roundsController.text,
                                  _trainingDuration.text,
                                  _breakDuration.text);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage(),
                                ),
                              );
                            }
                          },
                          child: Text("Add training session"),
                        ),
                      ),
                    ],
                  ),
                ),
                color: primaryTheme,
              ),
            ),
          );
  }
}
