import 'dart:async';

import 'package:flutter/material.dart';
import 'package:interval_timer_app/models/trainingSessionModel.dart';
import 'package:interval_timer_app/utils/colors.dart';
import 'package:interval_timer_app/utils/loader.dart';
import 'package:interval_timer_app/utils/sizeConfig.dart';
import 'package:interval_timer_app/utils/styles.dart';
import 'package:interval_timer_app/view/trainingSession/widgets/alertDialog.dart';
import 'package:interval_timer_app/viewModel/trainingSession/trainingSessionViewModel.dart';

///Main screen of the app. After we get the needed parameters, we initialize them in didChangeDependencies method, a method that fires after initState method (method in which we initialize the state of the app - data
///that this screen uses) and build method which essentialy renders the UI.
class TrainingSession extends StatefulWidget {
  final TrainingSessionModel tsm;

  TrainingSession(this.tsm);
  @override
  _TrainingSessionState createState() => _TrainingSessionState();
}

class _TrainingSessionState extends State<TrainingSession> {
  int initRoundsInt,
      initTrainingIntervalSeconds,
      initTrainingIntervalMinutes,
      initBreakIntervalSeconds,
      initBreakIntervalMinutes;
  Future<String> quote;

  int currentRound;
  int currentMinutes;
  int currentSeconds;

  bool trainingTime;
  bool timeTicking;
  bool started;
  bool ended;

  Timer _timer;

  ///Start timer function is the function that fires when user taps on play button. At the start we set started to true and cancel the timer if it exists. timeTicking is set to true and then the timer starts ticking. We set the timer using periodic
  ///named constructor of Timer class. It takes a duration as the first argument and a callback as the second argument. Callback will be fired once every x seconds depending on the first parameter. Afterwards, if the number of seconds is greater than 0,
  ///we decrease it or if it isn't we check if number of minutes is greater than 0. If it is, we decrease number of minutes and increase number of seconds by 59. If both of them are 0, that means that we're at the end of an interval (training or break).
  ///If the current round is the same as total number of rounds, that means we've reached the end of the session. It it's not, we just proceed to the next interval (either break or training).
  ///It's all body of a setState function which means we want to rerender our screen after every change of the state.
  ///We have underscore before the name because we defined as private function to this class.
  void _startTimer() {
    if (!started) started = true;
    if (_timer != null) {
      _timer.cancel();
    }
    timeTicking = true;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (currentSeconds > 0) {
          currentSeconds--;
        } else if (currentMinutes > 0) {
          currentMinutes--;
          currentSeconds += 59;
        } else if (currentRound < initRoundsInt) {
          if (trainingTime) {
            trainingTime = false;
            currentMinutes = initBreakIntervalMinutes;
            currentSeconds = initBreakIntervalSeconds;
          } else {
            trainingTime = true;
            currentRound++;
            currentMinutes = initTrainingIntervalMinutes;
            currentSeconds = initTrainingIntervalSeconds;
          }
        } else {
          _timer.cancel();
        }
      });
    });
  }

  ///A function that fires when user taps on pause button. Only thing we do here is that we set timeTicking to false so we could disable pause and stop buttons as well as cancel the timer so it stops running.
  void _pauseTimer() {
    setState(() {
      timeTicking = false;
      if (_timer != null) {
        _timer.cancel();
      }
    });
  }

  ///A function that fires when user taps on reset or stop button. Basically, all the variables are reset to starting values.
  void _resetTimer() {
    setState(() {
      timeTicking = false;
      ended = false;
      trainingTime = true;
      currentRound = 1;
      currentSeconds = initTrainingIntervalSeconds;
      currentMinutes = initTrainingIntervalMinutes;
    });
  }

  ///Function which we call when the user has pressed stop button. It uses both reset and pause functions for it functionality.
  void _stopTimer() {
    _resetTimer();
    _pauseTimer();
  }

  ///As previously said, number of rounds, training interval minutes and seconds counts and break interval minutes and seconds counts are initialized (~/ is whole number division and % gets remainder of division). After that the integers that will
  ///be actually rendered on the screen are initialized (we user same variables for both training and break intervals as there's no need to create separate ones - this way it's leaner and easier to read). Also helper variables are defined
  ///which will help us manage screen rendering manipulation. trainingTime will be true when the training is occuring (helpful when we want to display different color or different text in different modes) and timeTicking will help us
  ///to disable buttons depending on whether the clock is ticking or not. If the time is ticking, then play button will be disabled and pause/stop buttons will be enabled and vice versa.
  ///Also we have started and ended boolean variables which are used to display different content depending on if the session has started or ended.
  ///Finally we set quote variable to use the string we fetched from a remote server.
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    initRoundsInt = widget.tsm.numberOfTrainingIntervals;
    int trainingInterval = widget.tsm.trainingIntervalDuration;
    initTrainingIntervalMinutes = trainingInterval ~/ 60;
    initTrainingIntervalSeconds = trainingInterval % 60;
    int breakInterval = widget.tsm.breakIntervalDuration;
    initBreakIntervalMinutes = breakInterval ~/ 60;
    initBreakIntervalSeconds = breakInterval % 60;

    currentRound = 1;
    currentMinutes = initTrainingIntervalMinutes;
    currentSeconds = initTrainingIntervalSeconds;

    trainingTime = true;
    timeTicking = false;

    started = false;
    ended = false;

    quote = fetchTheQuote();
    super.didChangeDependencies();
  }

  ///We have to destroy the timer every time we leave the screen as it may cause memory leak if we don't.
  @override
  void dispose() {
    // TODO: implement dispose
    if (_timer != null) {
      _timer.cancel();
    }
    super.dispose();
  }

  ///Following code is basically UI made of multiple Text widgets and SizedBox widgets to separate them. After we've initialized size config we return Scaffold from the build method. Body of scaffold widget is a FutureBuilder, a widget that has two
  ///main properties - future and builder. Future is result of asynchronous operation. Our asynchronous operation (operation that isn't performed instantly) is fetching data from a remote server and we need to wait a bit for it to complete.
  ///In builder method we display UI depending on the result of the future. If the operation hasn't finished yet, we display a loader screen - a nice UX feature. If the operation has finished, we can use the result of the operation and do something with it.
  ///Here we a simple sentence that we fetched so we simply output it on the screen. Besides that, we have motivational sentences (depending if we're training or resting), current round/total rounds, current time and of course the buttons.
  ///Much of below code doesn't need special explanation since it's very simple UI rendering code.
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    if (currentRound == initRoundsInt &&
        currentMinutes == 0 &&
        currentSeconds == 0) ended = true;
    return Scaffold(
      appBar: AppBar(
        title: Text("Training session"),
        actions: [
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                showDialog(
                    context: context,
                    builder: (_) => alertDialog(
                        () => Navigator.pop(context), context, widget.tsm));
              })
        ],
        backgroundColor: secondaryTheme,
      ),
      body: FutureBuilder(
        future: quote,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              height: SizeConfig.blockSizeVertical * 100,
              width: SizeConfig.blockSizeHorizontal * 100,
              color: (started && !trainingTime) ? secondaryTheme : primaryTheme,
              child: Column(
                children: [
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 10,
                  ),
                  Text(
                    snapshot.data.toString(),
                    style: TrainingSessionStyles().textStyle(7, context),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical,
                  ),

                  ///Display congratulations code if the session has ended and if it's not display other motivational content depending on if it's training or rest time and if the session is close to an end.
                  Text(
                    ended
                        ? "YOU DID IT!"
                        : trainingTime
                            ? currentRound == initRoundsInt
                                ? "LAST ROUND! KEEP GOING!"
                                : "IT'S TRAINING TIME!"
                            : currentRound == initRoundsInt - 1
                                ? "REST! ONE MORE LEFT!"
                                : "REST NOW! YOU GOT THIS!",
                    style: TrainingSessionStyles().textStyle(5, context),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 5,
                  ),
                  Text(
                    "Round:",
                    style: TrainingSessionStyles().textStyle(10, context),
                  ),
                  Text(
                    currentRound.toString() + "/" + initRoundsInt.toString(),
                    style: TrainingSessionStyles().textStyle(10, context),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 5,
                  ),
                  Text(
                    (currentMinutes < 10
                            ? "0" + currentMinutes.toString()
                            : currentMinutes.toString()) +
                        ":" +
                        (currentSeconds < 10
                            ? "0" + currentSeconds.toString()
                            : currentSeconds.toString()),
                    style: TrainingSessionStyles().textStyle(15, context),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 10,
                  ),

                  ///Buttons are, as previously said enabled and disabled depending if the time is ticking or not and if the session has ended or not. It's done as it made sense to do it in order to prevent some bugs and irregular timer behavior.
                  Row(
                    children: [
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 14,
                      ),
                      InkWell(
                        child: Icon(
                          Icons.play_circle_filled,
                          color: ternaryTheme,
                          size: SizeConfig.safeBlockHorizontal * 15,
                        ),
                        onTap: ended ? null : timeTicking ? null : _startTimer,
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 15,
                      ),
                      InkWell(
                        child: Icon(
                          Icons.pause_circle_filled,
                          color: ternaryTheme,
                          size: SizeConfig.safeBlockHorizontal * 15,
                        ),
                        onTap: ended ? null : timeTicking ? _pauseTimer : null,
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 15,
                      ),
                      InkWell(
                        child: Icon(
                          ended ? Icons.loop : Icons.stop,
                          color: ternaryTheme,
                          size: SizeConfig.safeBlockHorizontal * 15,
                        ),
                        onTap: () {
                          _stopTimer();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );

            ///If the snapshot contains an error (or exception), we can catch it and display it on the screen and in the console so we could debug.
          } else if (snapshot.hasError) {
            print(snapshot.error.toString());
            return Text(
              snapshot.error.toString(),
            );
          } else {
            return Loading();
          }
        },
      ),
    );
  }
}
