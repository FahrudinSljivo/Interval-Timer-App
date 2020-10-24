import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interval_timer_app/utils/globals.dart';
import 'package:interval_timer_app/view/authentication/register/register.dart';
import 'package:interval_timer_app/view/homepage/pages/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

splashScreenRouter(BuildContext context) async {
  //WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String haha = "";

  //print("DRUZIJAAAA" + prefs.getString("id"));
  haha = prefs.getString("id");
  currentlySignedUser = prefs.getString("id");

  print("CURRENTLY SIGNED USER");
  print(currentlySignedUser);
  print("CURRENTLY SIGNED USER2");
  print(haha);

  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) =>
              currentlySignedUser == null ? Register() : HomePage()));
}
