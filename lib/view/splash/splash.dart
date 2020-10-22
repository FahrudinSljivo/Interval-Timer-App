import 'dart:async';

import 'package:flutter/material.dart';
import 'package:interval_timer_app/utils/colors.dart';
import 'package:interval_timer_app/utils/globals.dart';
import 'package:interval_timer_app/utils/sizeConfig.dart';
import 'package:interval_timer_app/viewModel/splash/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

/*
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationController.repeat(reverse: true);
    _animation = Tween(begin: 5.0, end: 15.0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    super.didChangeDependencies();
  }
*/
  @override
  dispose() {
    //_animationController.dispose();
    super.dispose();
  }

  //AnimationController _animationController;

  //Animation _animation;

  @override
  Widget build(BuildContext context) {
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
