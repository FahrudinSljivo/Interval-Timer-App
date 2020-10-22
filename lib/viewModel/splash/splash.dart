import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interval_timer_app/utils/globals.dart';
import 'package:interval_timer_app/view/authentication/register/register.dart';
import 'package:interval_timer_app/view/homepage/pages/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

splashScreenRouter(BuildContext context) async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String haha = prefs.getString('id');
  currentlySignedUser = prefs.getString('id');

  print("CURRENTLY SIGNED USER");
  print(currentlySignedUser);
  print(haha);

  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) =>
              currentlySignedUser == null ? Register() : HomePage()));
}
