import 'package:flutter/material.dart';
import 'package:interval_timer_app/utils/colors.dart';
import 'package:interval_timer_app/utils/sizeConfig.dart';
import 'package:interval_timer_app/view/authentication/login/login.dart';
import 'package:interval_timer_app/view/authentication/sharedWidgets/emailTile.dart';
import 'package:interval_timer_app/view/authentication/sharedWidgets/passwordTile.dart';
import 'package:interval_timer_app/view/authentication/sharedWidgets/submitButton.dart';
import 'package:interval_timer_app/view/authentication/sharedWidgets/switchButton.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        color: primaryTheme,
        child: Form(
          child: Column(
            children: [
              SizedBox(
                height: SizeConfig.blockSizeVertical * 15,
              ),
              Center(
                child: Text(
                  "Register",
                  style: TextStyle(
                    color: ternaryTheme,
                    fontSize: SizeConfig.safeBlockHorizontal * 7,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              EmailTile(),
              PasswordTile('Password', 'Enter your Password'),
              PasswordTile('Confirm Password', 'Confirm your Password'),
              SubmitButton('REGISTER'),
              SwitchButton('Already have an account? ', 'Sign in', () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Login(),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
