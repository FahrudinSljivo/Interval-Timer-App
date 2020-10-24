import 'package:flutter/material.dart';
import 'package:interval_timer_app/models/trainingSessionModel.dart';
import 'package:interval_timer_app/providers/trainingSessionsProvider.dart';
import 'package:interval_timer_app/utils/colors.dart';
import 'package:interval_timer_app/utils/globals.dart';
import 'package:interval_timer_app/utils/loader.dart';
import 'package:interval_timer_app/view/addTrainingSession/pages/addTrainingSession.dart';
import 'package:interval_timer_app/view/authentication/login/login.dart';
import 'package:interval_timer_app/view/homepage/widgets/trainingSessionTile.dart';
import 'package:interval_timer_app/view/sharedWidgets/deleteAlertDialog.dart';
import 'package:interval_timer_app/viewModel/auth/auth.dart';
import 'package:interval_timer_app/viewModel/trainingSession/trainingSession.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TrainingSessionModel> trainingSessionsList = [];
  final Auth _auth = Auth();
  TrainingSessionModel t = TrainingSessionModel(
    id: "1",
    title: "First training session",
    trainingIntervalDuration: 60,
    breakIntervalDuration: 30,
    numberOfTrainingIntervals: 5,
  );

  @override
  Widget build(BuildContext context) {
    print("DIREKT IZ SERD PRIFERENSESA");
    SharedPreferences.getInstance().then((value) {
      print(value.getString("id"));
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Your training sessions'),
        backgroundColor: secondaryTheme,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.power_settings_new),
            onPressed: () async {
              await _auth.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Login(),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        color: primaryTheme,
        child: FutureBuilder(
            future:
                TrainingSession().fetchTrainingSessions(currentlySignedUser),
            builder: (context, snapshot) {
              /*Provider.of<TrainingSessionsProvider>(context, listen: false)
                  .fetchAndSetTrainingSessions(snapshot.data);
              var trainingSessionsList =
                  Provider.of<TrainingSessionsProvider>(context, listen: false)
                      .trainingSessions;*/
              if (snapshot.hasData) {
                trainingSessionsList = snapshot.data
                    .map(
                      (trainingSession) => TrainingSessionModel(
                        id: trainingSession['trainingSessionId'],
                        title: trainingSession['title'],
                        numberOfTrainingIntervals:
                            int.parse(trainingSession['rounds']),
                        trainingIntervalDuration:
                            int.parse(trainingSession['trainingDuration']),
                        breakIntervalDuration:
                            int.parse(trainingSession['breakDuration']),
                      ),
                    )
                    .toList()
                    .cast<TrainingSessionModel>();
                return snapshot.data == []
                    ? Center(
                        child: Text(
                          "You have no training sessions yet. \nTry adding some!",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : ListView(
                        children: trainingSessionsList
                            .map((e) => TrainingSessionTile(e))
                            .toList());
              } else {
                return Loading();
              }
            }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTrainingSession(),
            ),
          );
        },
        backgroundColor: secondaryTheme,
        child: Icon(
          Icons.add,
        ),
        elevation: 0,
      ),
    );
  }
}
