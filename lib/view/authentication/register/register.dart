import 'package:flutter/material.dart';
import 'package:interval_timer_app/utils/colors.dart';
import 'package:interval_timer_app/utils/loader.dart';
import 'package:interval_timer_app/utils/sizeConfig.dart';
import 'package:interval_timer_app/view/authentication/login/login.dart';
import 'package:interval_timer_app/view/authentication/sharedWidgets/emailTile.dart';
import 'package:interval_timer_app/view/authentication/sharedWidgets/passwordTile.dart';
import 'package:interval_timer_app/view/authentication/sharedWidgets/submitButton.dart';
import 'package:interval_timer_app/view/authentication/sharedWidgets/switchButton.dart';
import 'package:auth/auth.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _registerFormKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  bool loading = false;
  void refresh(bool loadingToTrue) {
    setState(() {
      loadingToTrue ? loading = true : loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: loading
          ? Loading()
          : Container(
              height: SizeConfig.blockSizeVertical * 100,
              color: primaryTheme,
              child: Form(
                key: _registerFormKey,
                child: SingleChildScrollView(
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
                      EmailTile(_email),
                      PasswordTile(
                        labelText: 'Password',
                        hintText: 'Enter your Password',
                        passController: _pass,
                      ),
                      PasswordTile(
                        labelText: 'Confirm Password',
                        hintText: 'Confirm your Password',
                        passController: _pass,
                        confirmPassController: _confirmPass,
                      ),
                      SubmitButton('REGISTER', _registerFormKey, true, _email,
                          _pass, refresh, context),
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
            ),
    );
  }
}
