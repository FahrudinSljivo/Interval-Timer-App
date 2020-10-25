import 'dart:async';

import 'package:flutter/material.dart';
import 'package:interval_timer_app/models/trainingSessionModel.dart';
import 'package:interval_timer_app/utils/colors.dart';
import 'package:interval_timer_app/utils/loader.dart';
import 'package:interval_timer_app/utils/sizeConfig.dart';
import 'package:interval_timer_app/utils/styles.dart';
import 'package:interval_timer_app/view/trainingSession/widgets/alertDialog.dart';
import 'package:interval_timer_app/viewModel/trainingSession/trainingSessionViewModel.dart';

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

  void _pauseTimer() {
    setState(() {
      timeTicking = false;
      if (_timer != null) {
        _timer.cancel();
      }
    });
  }

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

  void _stopTimer() {
    _resetTimer();
    _pauseTimer();
  }

  //AlertDialog _alert;

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

    //_alert = alertDialog(_resetTimer, context, widget.tsm);

    quote = fetchTheQuote();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (_timer != null) {
      _timer.cancel();
    }
    super.dispose();
  }

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
