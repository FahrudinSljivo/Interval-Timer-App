import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interval_timer_app/utils/globals.dart';
import 'package:interval_timer_app/view/authentication/register/register.dart';
import 'package:interval_timer_app/view/homepage/pages/homepage.dart';
import 'package:interval_timer_app/viewModel/auth/auth.dart';

splashScreenRouter(BuildContext context) async {
  ///We use the result of this function (which returns the currently signed user, null if nobody is signed in on a particular device) in order to autologin a user if he hasn't logged out or to show register/login screen if he has.
  final String result = await Auth().currentUser();

  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => result == "success" ? HomePage() : Register()));
}
