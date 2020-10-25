import 'dart:async';

import 'package:flutter/material.dart';
import 'package:interval_timer_app/utils/colors.dart';
import 'package:interval_timer_app/utils/globals.dart';
import 'package:interval_timer_app/utils/sizeConfig.dart';
import 'package:interval_timer_app/viewModel/splash/splash.dart';

///Screen we display at the very start. It's rendered for 3 seconds before we decide if the user is already logged in or not.
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ///After 3 seconds we fire a method splashScreenRouter where we check if user is logged in or not. Everything below it is simple UI rendering and no logic.
    Timer(Duration(seconds: 3), () => splashScreenRouter(context));
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        height: SizeConfig.blockSizeVertical * 100,
        width: SizeConfig.blockSizeHorizontal * 100,
        color: primaryTheme,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Container(
              width: 100,
              height: 100,
              child: Icon(
                Icons.timer,
                color: ternaryTheme,
                size: SizeConfig.blockSizeHorizontal * 20,
              ),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black54,
                  boxShadow: [
                    BoxShadow(
                        color: secondaryTheme, blurRadius: 15, spreadRadius: 15)
                  ]),
            )),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 5,
            ),
            Text(
              "Loading...",
              style: TextStyle(
                color: ternaryTheme,
                fontSize: SizeConfig.safeBlockHorizontal * 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
