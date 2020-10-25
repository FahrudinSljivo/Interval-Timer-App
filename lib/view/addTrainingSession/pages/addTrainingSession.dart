import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interval_timer_app/models/trainingSessionModel.dart';
import 'package:interval_timer_app/providers/trainingSessionsProvider.dart';
import 'package:interval_timer_app/utils/colors.dart';
import 'package:interval_timer_app/utils/loader.dart';
import 'package:interval_timer_app/utils/sizeConfig.dart';
import 'package:interval_timer_app/view/addTrainingSession/widgets/formField.dart';
import 'package:interval_timer_app/viewModel/trainingSession/trainingSessionViewModel.dart';
import 'package:provider/provider.dart';

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
    final provider = Provider.of<TrainingSessionsProvider>(context);
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
                        height: SizeConfig.blockSizeVertical * 9,
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
                        height: SizeConfig.blockSizeVertical * 2,
                      ),
                      Center(
                        child: RaisedButton(
                          onPressed: () {
                            if (_newTSKey.currentState.validate()) {
                              setState(() {
                                loading = true;
                              });
                              String tsId = generateRandomString(20);
                              provider.addTrainingSession(TrainingSessionModel(
                                  id: tsId,
                                  title: _titleController.text,
                                  numberOfTrainingIntervals:
                                      int.parse(_roundsController.text),
                                  trainingIntervalDuration:
                                      int.parse(_trainingDuration.text),
                                  breakIntervalDuration:
                                      int.parse(_breakDuration.text)));
                              TrainingSessionViewModel().addNewTrainingSession(
                                  tsId,
                                  _titleController.text,
                                  _roundsController.text,
                                  _trainingDuration.text,
                                  _breakDuration.text);
                              Navigator.pop(context);
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
