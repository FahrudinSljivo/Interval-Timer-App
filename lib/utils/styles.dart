import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interval_timer_app/utils/colors.dart';
import 'package:interval_timer_app/utils/sizeConfig.dart';

class AuthScreensStyles {
  final hintTextStyle = TextStyle(
    color: ternaryTheme,
  );

  final labelStyle = TextStyle(
    color: ternaryTheme,
    fontWeight: FontWeight.bold,
  );

  final boxDecorationStyle = BoxDecoration(
    color: secondaryTheme,
    borderRadius: BorderRadius.circular(10.0),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 6.0,
        offset: Offset(0, 2),
      ),
    ],
  );
}

class HomePageStyles {
  final tsTileTitle = TextStyle(
    color: ternaryTheme,
    fontSize: SizeConfig.safeBlockHorizontal * 4,
  );
}

class NewTrainingSessionStyles {
  inputFieldStyle({String labelText, String hintText = ""}) {
    return InputDecoration(
      helperStyle: TextStyle(
        color: ternaryTheme,
      ),
      hintText: hintText,
      labelText: labelText,
      labelStyle: TextStyle(
        color: ternaryTheme,
      ),
      hintStyle: TextStyle(
        color: ternaryTheme,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white, width: 2.0),
        //borderRadius: BorderRadius.circular(25.0),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey, width: 0.0),
      ),
    );
  }
}
