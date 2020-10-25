import 'package:flutter/material.dart';
import 'package:interval_timer_app/providers/trainingSessionsProvider.dart';
import 'package:interval_timer_app/utils/colors.dart';
import 'package:interval_timer_app/utils/globals.dart';
import 'package:interval_timer_app/utils/loader.dart';
import 'package:interval_timer_app/view/addTrainingSession/pages/addTrainingSession.dart';
import 'package:interval_timer_app/view/authentication/login/login.dart';
import 'package:interval_timer_app/view/homepage/widgets/trainingSessionTile.dart';
import 'package:interval_timer_app/viewModel/auth/auth.dart';
import 'package:interval_timer_app/viewModel/trainingSession/trainingSessionViewModel.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Auth _auth = Auth();

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TrainingSessionsProvider>(context);
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
            future: TrainingSessionViewModel()
                .fetchTrainingSessions(currentlySignedUser),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                provider.fetchAndSetTrainingSessions(snapshot.data);
                /*trainingSessionsList = snapshot.data
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
                    .cast<TrainingSessionModel>();*/
                return provider.trainingSessions.length == 0
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
                        children: provider.trainingSessions
                            .map((e) => TrainingSessionTile(e, refresh))
                            .toList());
              } else {
                return Loading();
              }
            }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //setState(() {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTrainingSession(),
            ),
          );
          //});
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
