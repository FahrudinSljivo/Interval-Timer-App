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

///This is the page where all the training session tiles are displayed.
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ///Instance of Auth class used for firebase user management
  final Auth _auth = Auth();

  @override
  Widget build(BuildContext context) {
    ///Instance of TrainingSessionsProvider - an instance which we can use to manipulate the state.
    final provider = Provider.of<TrainingSessionsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your training sessions'),
        backgroundColor: secondaryTheme,
        elevation: 0,
        actions: [
          ///Signout button - on pressed triggers the signOut method and navigates us to login screen
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

      ///We have here FutureBuilder whose future fetches all the training sessions for the logged in user. In the builder method, if the future didn't finished, we display a loader. That can happen in case of an error, exception, no internet etc... In case
      ///the snapshot has data, we store the data in the list of the TrainingSessionProvider. In case the list is empty, we display appropriate content to the user and if it's not, we map each class instance to TrainingSessionTile. Those tiles are obviously
      ///rendered inside a ListView.
      body: Container(
        color: primaryTheme,
        child: FutureBuilder(
            future: TrainingSessionViewModel()
                .fetchTrainingSessions(currentlySignedUser),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                provider.fetchAndSetTrainingSessions(snapshot.data);
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
                            .map((e) => TrainingSessionTile(e))
                            .toList());
              } else {
                return Loading();
              }
            }),
      ),

      ///Positioning of a floating action button which is used for adding new training session.
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      ///Floating action button which on pressed will trigger navigation to AddTrainingSession screen.
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
