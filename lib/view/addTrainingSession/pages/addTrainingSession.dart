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

///Screen where we have form that collects info about the training session parameters. There are 4 form fields here responsible for collecting user data
///on name, number of rounds, training duration and break duration.
class AddTrainingSession extends StatefulWidget {
  @override
  _AddTrainingSessionState createState() => _AddTrainingSessionState();
}

class _AddTrainingSessionState extends State<AddTrainingSession> {
  ///We define global key as a state object which we will use as a key of the form below. Form needs the key because the validation of the form input is done with this key.
  ///Also, we have 3 text editing controllers for collecting user input. These controllers will, of course, be assigned to text form fields defined down below.
  final _newTSKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _roundsController = TextEditingController();
  final TextEditingController _trainingDuration = TextEditingController();
  final TextEditingController _breakDuration = TextEditingController();

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    ///Size config is initialized here using the context of this screen. Size config class description done in the class itself.
    ///Appbar, as well as container below are colored with predefined colors in colors.dart
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

            ///Form is wrapped with SingleChildScrollView widget because that's how we make the column scrollable - solution to a bottom overflow when the keyboard pops up because the screen becomes too small for the Column widget.
            ///Container's height is set to 100% of the screen height as a solution to a weird behavior of Column wrapped with SingleChildScrollView.
            ///After that we have 4 custom form fields to which we pass label text, controller of the form field and smallest number a user can enter as arguments.
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

                      ///Eventually we have a submit button with which we, after the validation succeeds, generate a random 20-character string and then add the training session to the provider list and then make a request to insert it into the training sessions
                      ///collection in firestore of the currently logged in user. After that, this screen is popped off the stack and we return to the home page.
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
