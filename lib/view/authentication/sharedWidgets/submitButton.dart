import 'package:flutter/material.dart';
import 'package:interval_timer_app/utils/colors.dart';
import 'package:interval_timer_app/utils/sizeConfig.dart';
import 'package:interval_timer_app/view/homepage/pages/homepage.dart';
import 'package:interval_timer_app/viewModel/auth/auth.dart';

///A submit button on login and register screens. It basically, depending on whether the user is signing in or signing up, fires different Auth methods and navigates then to home screen.
class SubmitButton extends StatefulWidget {
  final String submitText;
  final dynamic formKey;
  final bool isRegistering;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Function refresh;
  final BuildContext parentContext;

  SubmitButton(
      this.submitText,
      this.formKey,
      this.isRegistering,
      this.emailController,
      this.passwordController,
      this.refresh,
      this.parentContext);

  @override
  _SubmitButtonState createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  final Auth _auth = Auth();
  GlobalKey loadingWidgetKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    ///SizeConfig initialized so it can be used for widget styling.
    SizeConfig().init(context);
    return Padding(
      padding: EdgeInsets.only(
        top: SizeConfig.blockSizeVertical * 8,
      ),
      child: Container(
        width: SizeConfig.blockSizeHorizontal * 60,
        child: RaisedButton(
          elevation: 5.0,
          onPressed: () async {
            ///checking if the form validation succeeds
            if (widget.formKey.currentState.validate()) {
              ///function that fires setState of the parent widget (login/register) - displaying loader to the user because async operation has commenced
              widget.refresh(true);

              ///if the user is in register screen, fire registerWithEmailAndPassword function and check for result. If it succeeds go to home page and if not, inform the user that the registration hasn't succeeded.
              if (widget.isRegistering) {
                dynamic result = await _auth.registerWithEmailAndPassword(
                    widget.emailController.text.trim(),
                    widget.passwordController.text.trim());
                if (result == null) {
                  widget.refresh(false);
                  print("It didn't manage to register");
                } else {
                  print("It did manage to register");
                  Navigator.pushReplacement(
                    widget.parentContext,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                }

                ///if the user is in login screen, fire signInWithEmailAndPassword function and check for result. If it succeeds go to home page and if not, inform the user that the login hasn't succeeded.
              } else {
                dynamic result = await _auth.signInWithEmailAndPassword(
                    widget.emailController.text.trim(),
                    widget.passwordController.text.trim());
                if (result == null) {
                  widget.refresh(false);
                  print("It didn't manage to login");
                } else {
                  print("It did manage to login");
                  Navigator.pushReplacement(
                    widget.parentContext,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                }
              }
            } else {
              print("Validation is not successful");
            }
          },

          ///some more button styling
          padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          color: ternaryTheme,
          child: Text(
            widget.submitText,
            style: TextStyle(
              color: secondaryTheme,
              letterSpacing: 1.5,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
