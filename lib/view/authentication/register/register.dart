import 'package:flutter/material.dart';
import 'package:interval_timer_app/utils/colors.dart';
import 'package:interval_timer_app/utils/loader.dart';
import 'package:interval_timer_app/utils/sizeConfig.dart';
import 'package:interval_timer_app/view/authentication/login/login.dart';
import 'package:interval_timer_app/view/authentication/sharedWidgets/emailTile.dart';
import 'package:interval_timer_app/view/authentication/sharedWidgets/passwordTile.dart';
import 'package:interval_timer_app/view/authentication/sharedWidgets/submitButton.dart';
import 'package:interval_timer_app/view/authentication/sharedWidgets/switchButton.dart';

///Screen containing new user registration form
class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  ///Properties are GlobalKey used for form validation as well as text editing controllers which track user input in the text fields.
  final _registerFormKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  bool loading = false;

  ///method that's fired when validation of the fields succeeds. It's argument would be true if the validation succeeds and false if it succeeds, but the future returns an error.
  void refresh(bool loadingToTrue) {
    setState(() {
      loadingToTrue ? loading = true : loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      ///If the form validation succeeds, loader is rendered since the fetching of information from remote server (cloud firestore) is commencing.
      ///Below we have simple UI which consists of 3 TextFormFields manually styled and a submit button.
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
                        height: SizeConfig.blockSizeVertical * 10,
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
