import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:interval_timer_app/utils/globals.dart';
import 'dart:math';

String generateRandomString(int len) {
  var r = Random();
  const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
}

bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return int.tryParse(s) != null;
}

class TrainingSessionViewModel {
  final dbInstance = FirebaseFirestore.instance;

  Future<void> addNewTrainingSession(String title, String rounds,
      String trainingDuration, String breakDuration) async {
    String tsId = generateRandomString(20);
    await dbInstance
        .collection('users')
        .doc(currentlySignedUser)
        .collection('trainingSessions')
        .doc(tsId)
        .set({
      'trainingSessionId': tsId,
      'title': title,
      'rounds': rounds,
      'trainingDuration': trainingDuration,
      'breakDuration': breakDuration,
    });
  }

  Future<List<DocumentSnapshot>> fetchTrainingSessions(String userId) async {
    final QuerySnapshot qs = await dbInstance
        .collection('users')
        .doc(userId)
        .collection('trainingSessions')
        .get();

    List<DocumentSnapshot> trainingSessions = qs.docs;

    return trainingSessions;
  }

  Future<void> deleteTrainingSession(String userId, String id) async {
    await dbInstance
        .collection('users')
        .doc(userId)
        .collection('trainingSessions')
        .doc(id)
        .delete();
  }
}
