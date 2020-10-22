import 'package:flutter/material.dart';
import 'package:interval_timer_app/utils/colors.dart';
import 'package:interval_timer_app/utils/sizeConfig.dart';
import 'package:interval_timer_app/utils/styles.dart';

class NewSessionFormField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextInputType inputType;
  final TextEditingController fieldController;

  NewSessionFormField(
      {this.labelText,
      this.hintText = "",
      this.inputType = TextInputType.number,
      this.fieldController});
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
            style: TextStyle(color: ternaryTheme),
            controller: fieldController,
            validator: (value) {
              if (value.isEmpty) {
                return 'Field can\'t be empty';
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
