import 'package:flutter/material.dart';
import 'package:interval_timer_app/utils/sizeConfig.dart';
import 'package:interval_timer_app/utils/styles.dart';

class PasswordTile extends StatelessWidget {
  final String labelText, hintText;

  PasswordTile(this.labelText, this.hintText);
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
            height: 60.0,
            child: TextField(
              obscureText: true,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
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
