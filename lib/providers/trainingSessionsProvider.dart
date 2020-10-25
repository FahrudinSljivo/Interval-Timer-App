import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:interval_timer_app/models/trainingSessionModel.dart';

///Provider class of the training sessions for a particular user. Provider is a state management system where we have a class that uses ChangeNotifier class as a mixin and defines it's own properties and methods. Methods usually have notifyListeners methods
///in them (from ChangeNotifier class) which tell the flutter to re-render the screen because the state has changed. Widgets can access these methods and properties by wrapping one of it's parent widgets (usually the root widget) with ChangeNotifierProvider widget.
class TrainingSessionsProvider with ChangeNotifier {
  List<TrainingSessionModel> _trainingSessions = [];

  ///training sessions getter
  List<TrainingSessionModel> get trainingSessions {
    return [..._trainingSessions];
  }

  ///getting document snapshot list (from firestore usually) and mapping each of its entries into a TrainingSessionModel class instance. That list is then assigned to _trainingSession list.
  fetchAndSetTrainingSessions(List<DocumentSnapshot> list) {
    _trainingSessions = list
        .map(
          (trainingSession) => TrainingSessionModel(
            id: trainingSession['trainingSessionId'],
            title: trainingSession['title'],
            numberOfTrainingIntervals: int.parse(trainingSession['rounds']),
            trainingIntervalDuration:
                int.parse(trainingSession['trainingDuration']),
            breakIntervalDuration: int.parse(trainingSession['breakDuration']),
          ),
        )
        .toList();
    //notifyListeners();
  }

  ///Adding training session and notifying listeners
  void addTrainingSession(TrainingSessionModel tsm) {
    _trainingSessions.add(tsm);
    notifyListeners();
  }

  ///Removing training session and notifying listeners
  void removeTrainingSession(TrainingSessionModel tsm) {
    _trainingSessions.remove(tsm);
    notifyListeners();
  }
}
