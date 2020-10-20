import 'package:flutter/material.dart';
import 'package:interval_timer_app/utils/colors.dart';
import 'package:interval_timer_app/utils/sizeConfig.dart';

class SubmitButton extends StatelessWidget {
  final String submitText;

  SubmitButton(this.submitText);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: EdgeInsets.only(
        top: SizeConfig.blockSizeVertical * 8,
      ),
      child: Container(
        width: SizeConfig.blockSizeHorizontal * 60,
        child: RaisedButton(
          elevation: 5.0,
          onPressed: () => print('Login Button Pressed'),
          padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          color: ternaryTheme,
          child: Text(
            submitText,
            style: TextStyle(
              color: secondaryTheme,
              letterSpacing: 1.5,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
      ),
    );
  }
}
