import 'package:flutter/material.dart';
import 'package:interval_timer_app/utils/colors.dart';

class DeleteAlertDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Delete training session?"),
      content: Text("Are you sure you want to delete this training session?"),
      actions: [
        FlatButton(
          child: Text(
            "NO",
          ),
          onPressed: () {},
        ),
        FlatButton(
          child: Text(
            "YES",
          ),
          onPressed: () {},
        ),
      ],
      elevation: 0,
      backgroundColor: ternaryTheme,
    );
  }
}
