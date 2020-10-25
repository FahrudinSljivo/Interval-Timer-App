import 'package:flutter/material.dart';
import 'package:interval_timer_app/utils/colors.dart';
import 'package:interval_timer_app/utils/sizeConfig.dart';
import 'package:interval_timer_app/utils/styles.dart';
import 'package:interval_timer_app/viewModel/trainingSession/trainingSessionViewModel.dart';

///Widget that wraps TextFormField widget. Since form fields differ in terms of validation as well as other properties, refactoring of widgets was made in order to make code a bit leaner and easier to read.
///Basic validation is done on the input fields - fields can't be empty and nothing except numbers higher or equal to atLeast parameter can be entered.
///Text form field styling is done in separate file and called here as a function.
class NewSessionFormField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextInputType inputType;
  final TextEditingController fieldController;
  final int atLeast;

  NewSessionFormField(
      {this.labelText,
      this.hintText = "",
      this.inputType = TextInputType.number,
      this.fieldController,
      this.atLeast});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: SizeConfig.blockSizeHorizontal * 5,
          ),
          child: TextFormField(
            maxLength: labelText == "Enter a title" ? 32 : 5,
            style: TextStyle(color: ternaryTheme),
            controller: fieldController,
            validator: (value) {
              if (value.isEmpty) {
                return 'Field can\'t be empty';
              }
              if (!(labelText == "Enter a title")) {
                if (!isNumeric(value))
                  return ('Input is limited only to integers');
                if (int.parse(value) < atLeast) {
                  return ('Can\'t enter smaller number than $atLeast');
                }
              }

              return null;
            },
            keyboardType: inputType,
            decoration: NewTrainingSessionStyles()
                .inputFieldStyle(labelText: labelText, hintText: hintText),
          ),
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 3,
        ),
      ],
    );
  }
}
