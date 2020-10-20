import 'package:flutter/material.dart';
import 'package:interval_timer_app/utils/colors.dart';
import 'package:interval_timer_app/utils/sizeConfig.dart';
import 'package:interval_timer_app/view/authentication/register/register.dart';
import 'package:interval_timer_app/view/authentication/sharedWidgets/emailTile.dart';
import 'package:interval_timer_app/view/authentication/sharedWidgets/passwordTile.dart';
import 'package:interval_timer_app/view/authentication/sharedWidgets/submitButton.dart';
import 'package:interval_timer_app/view/authentication/sharedWidgets/switchButton.dart';

class Login extends StatelessWidget {
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
                height: SizeConfig.blockSizeVertical * 20,
              ),
              Center(
                child: Text(
                  "Login",
                  style: TextStyle(
                    color: ternaryTheme,
                    fontSize: SizeConfig.safeBlockHorizontal * 7,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              EmailTile(),
              PasswordTile('Password', 'Enter your Password'),
              SubmitButton('LOGIN'),
              SwitchButton('Don\'t have an Account? ', 'Sign Up', () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Register(),
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
