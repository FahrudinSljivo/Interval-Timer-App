import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:interval_timer_app/utils/sizeConfig.dart';

///A widget which is represents the helper text on login and register screens. It basically informs a user when in register to change to login screen if he has an account and vice versa.
class SwitchButton extends StatelessWidget {
  final String textQuestion, textButton;
  final Function switchScreen;

  SwitchButton(this.textQuestion, this.textButton, this.switchScreen);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: EdgeInsets.only(
        top: SizeConfig.blockSizeVertical * 5,
      ),

      ///RichText is a widget which helps us to manipulate strings more easily by treating different parts of the complete string differently. Here we have two strings where one is clickable and the other one is not.
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: textQuestion,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),

            ///This text span has an gesture detector which basically fires a function that's passed in as an argument. The function passed in is either to switch from login to register screen or vice versa.
            TextSpan(
              text: textButton,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
              recognizer: new TapGestureRecognizer()..onTap = switchScreen,
            ),
          ],
        ),
      ),
    );
  }
}
