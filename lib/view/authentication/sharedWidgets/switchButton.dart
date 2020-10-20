import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:interval_timer_app/utils/sizeConfig.dart';

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
