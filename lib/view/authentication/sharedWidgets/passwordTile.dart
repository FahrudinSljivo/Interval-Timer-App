import 'package:flutter/material.dart';
import 'package:interval_timer_app/utils/sizeConfig.dart';
import 'package:interval_timer_app/utils/styles.dart';

class PasswordTile extends StatelessWidget {
  final String labelText, hintText;
  final TextEditingController passController, confirmPassController;

  PasswordTile(
      {this.labelText,
      this.hintText,
      this.passController,
      this.confirmPassController = null});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: EdgeInsets.only(
        left: SizeConfig.blockSizeHorizontal * 10,
        right: SizeConfig.blockSizeHorizontal * 10,
        bottom: SizeConfig.blockSizeVertical * 3,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            labelText,
            style: AuthScreensStyles().labelStyle,
          ),
          SizedBox(height: 10.0),
          Container(
            alignment: Alignment.centerLeft,
            decoration: AuthScreensStyles().boxDecorationStyle,
            height: SizeConfig.blockSizeVertical * 7.5,
            child: TextFormField(
              controller: confirmPassController == null
                  ? passController
                  : confirmPassController,
              validator: (value) {
                if (value.length < 8) {
                  return '     Please enter password at least 8 characters long';
                }
                if (confirmPassController == null) return null;
                if (passController.text != value) {
                  return '     Passwords don\'t match';
                }
                return null;
              },
              obscureText: true,
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
                hintText: hintText,
                hintStyle: AuthScreensStyles().hintTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
