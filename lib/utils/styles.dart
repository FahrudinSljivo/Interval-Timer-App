import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interval_timer_app/utils/colors.dart';
import 'package:interval_timer_app/utils/sizeConfig.dart';

class AuthScreensStyles {
  final hintTextStyle = TextStyle(
    color: ternaryTheme,
    fontFamily: 'OpenSans',
  );

  final labelStyle = TextStyle(
    color: ternaryTheme,
    fontWeight: FontWeight.bold,
    fontFamily: 'OpenSans',
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
