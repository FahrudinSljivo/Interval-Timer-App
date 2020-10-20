import 'package:flutter/material.dart';
import 'package:interval_timer_app/models/trainingSessionModel.dart';
import 'package:interval_timer_app/utils/colors.dart';
import 'package:interval_timer_app/view/homepage/widgets/trainingSessionTile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TrainingSessionModel t = TrainingSessionModel(
    id: "1",
    title: "First training session",
    trainingIntervalDuration: 60,
    breakIntervalDuration: 30,
    numberOfTrainingIntervals: 5,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your training sessions'),
        backgroundColor: secondaryTheme,
        elevation: 0,
      ),
      body: Container(
        color: primaryTheme,
        child: Center(
          child:
              /*Text(
            "You have no training sessions yet. \nTry adding some!",
            style: TextStyle(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),*/
              TrainingSessionTile(t),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: secondaryTheme,
        child: Icon(
          Icons.add,
        ),
        elevation: 0,
      ),
    );
  }
}
