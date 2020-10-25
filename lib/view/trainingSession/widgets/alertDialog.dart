import 'package:flutter/material.dart';
import 'package:interval_timer_app/models/trainingSessionModel.dart';
import 'package:interval_timer_app/providers/trainingSessionsProvider.dart';
import 'package:interval_timer_app/utils/colors.dart';
import 'package:interval_timer_app/utils/globals.dart';
import 'package:interval_timer_app/viewModel/trainingSession/trainingSessionViewModel.dart';
import 'package:provider/provider.dart';

alertDialog(Function fn, BuildContext context, TrainingSessionModel tsm) {
  final provider = Provider.of<TrainingSessionsProvider>(context);
  return AlertDialog(
      title: Text("Delete the training session?"),
      content: Text("Do you want to delete current training session?"),
      actions: [
        FlatButton(
          child: Text(
            "YES",
          ),
          onPressed: () async {
            provider.removeTrainingSession(tsm);

            await TrainingSessionViewModel()
                .deleteTrainingSession(currentlySignedUser, tsm.id);
            Navigator.pop(context);
            fn();
          },
        ),
        FlatButton(
          child: Text(
            "NO",
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
      elevation: 0,
      backgroundColor: ternaryTheme);
}
