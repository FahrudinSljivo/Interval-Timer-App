import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interval_timer_app/utils/colors.dart';
import 'package:interval_timer_app/utils/sizeConfig.dart';

///Here we have simple styles we used for styling form fields where we collect user input regarding the training session parameters as well as basically everything on the training session screen.

///Styling of widgets on auth screens - login and register.
class AuthScreensStyles {
  ///Style for the placeholder text
  final hintTextStyle = TextStyle(
    color: ternaryTheme,
  );

  ///Style for the descriptive text
  final labelStyle = TextStyle(
    color: ternaryTheme,
    fontWeight: FontWeight.bold,
  );

  ///Style of the form field border
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

///Styling of homepage widgets
class HomePageStyles {
  final tsTileTitle = TextStyle(
    color: ternaryTheme,
    fontSize: SizeConfig.safeBlockHorizontal * 4,
  );
}

class NewTrainingSessionStyles {
  ///Styling is made by adding hint text (placeholder), label text (short description), coloring of helper text (max length bottom right text), label text and hint text. Finally borders of the text form field widget are set to be white or grey depending
  ///on whether the form field is focused.
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

///Styling of the text in training session screen. Screen text will have different sizes, but same color and font weight. Size config is initialized to make the text size rendering a bit more responsive.

class TrainingSessionStyles {
  textStyle(int size, BuildContext context) {
    SizeConfig().init(context);
    return TextStyle(
        color: ternaryTheme,
        fontSize: SizeConfig.safeBlockHorizontal * size,
        fontWeight: FontWeight.bold);
  }
}
