import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interval_timer_app/utils/globals.dart';
import 'package:interval_timer_app/view/authentication/register/register.dart';
import 'package:interval_timer_app/view/homepage/pages/homepage.dart';
import 'package:interval_timer_app/viewModel/auth/auth.dart';

splashScreenRouter(BuildContext context) async {
  final String result = await Auth().currentUser();

  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => result == "success" ? HomePage() : Register()));
}
