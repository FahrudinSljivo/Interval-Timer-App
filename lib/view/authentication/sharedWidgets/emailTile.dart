import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interval_timer_app/utils/colors.dart';
import 'package:interval_timer_app/utils/sizeConfig.dart';
import 'package:interval_timer_app/utils/styles.dart';

///A reusable widget (used both in login and register screens) which performs validation of email text field as well as its styling.
class EmailTile extends StatelessWidget {
  final TextEditingController emailController;

  EmailTile(this.emailController);
  @override
  Widget build(BuildContext context) {
    ///some ordinary email styling
    SizeConfig().init(context);
    return Padding(
      padding: EdgeInsets.only(
        left: SizeConfig.blockSizeHorizontal * 10,
        right: SizeConfig.blockSizeHorizontal * 10,
        top: SizeConfig.blockSizeVertical * 10,
        bottom: SizeConfig.blockSizeVertical * 3,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Email',
            style: AuthScreensStyles().labelStyle,
          ),
          SizedBox(height: 10.0),
          Container(
            alignment: Alignment.centerLeft,
            decoration: AuthScreensStyles().boxDecorationStyle,
            height: SizeConfig.blockSizeVertical * 7.5,
            child: TextFormField(
              ///simple email validation - proper could've been done using regex, but I decided it was unnecessary here
              validator: (value) {
                if (value.isEmpty || !value.contains('@')) {
                  return '     Please enter valid email address';
                }
                return null;
              },

              controller: emailController,

              ///additional email styling
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.white,
                ),
                hintText: 'Enter your Email',
                hintStyle: AuthScreensStyles().hintTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
