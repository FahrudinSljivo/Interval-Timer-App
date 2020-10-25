import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:interval_timer_app/models/trainingSessionModel.dart';

class TrainingSessionsProvider with ChangeNotifier {
  List<TrainingSessionModel> _trainingSessions = [];

  List<TrainingSessionModel> get trainingSessions {
    return [..._trainingSessions];
  }

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

  void addTrainingSession(TrainingSessionModel tsm) {
    _trainingSessions.add(tsm);
    notifyListeners();
  }

  void removeTrainingSession(TrainingSessionModel tsm) {
    _trainingSessions.remove(tsm);
    notifyListeners();
  }
}
