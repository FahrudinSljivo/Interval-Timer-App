import 'package:flutter/material.dart';
import 'package:interval_timer_app/utils/colors.dart';
import 'package:interval_timer_app/utils/loader.dart';
import 'package:interval_timer_app/utils/sizeConfig.dart';
import 'package:interval_timer_app/view/authentication/register/register.dart';
import 'package:interval_timer_app/view/authentication/sharedWidgets/emailTile.dart';
import 'package:interval_timer_app/view/authentication/sharedWidgets/passwordTile.dart';
import 'package:interval_timer_app/view/authentication/sharedWidgets/submitButton.dart';
import 'package:interval_timer_app/view/authentication/sharedWidgets/switchButton.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _loginFormKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();

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
                key: _loginFormKey,
                child: SingleChildScrollView(
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
                      EmailTile(_email),
                      PasswordTile(
                          labelText: 'Password',
                          hintText: 'Enter your Password',
                          passController: _pass),
                      SubmitButton('LOGIN', _loginFormKey, false, _email, _pass,
                          refresh, context),
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
            ),
    );
  }
}
