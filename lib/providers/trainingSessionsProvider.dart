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
            id: trainingSession['id'],
            title: trainingSession['title'],
            numberOfTrainingIntervals: trainingSession['rounds'],
            trainingIntervalDuration: trainingSession['trainingDuration'],
            breakIntervalDuration: trainingSession['breakDuration'],
          ),
        )
        .toList();
    notifyListeners();
  }
}
