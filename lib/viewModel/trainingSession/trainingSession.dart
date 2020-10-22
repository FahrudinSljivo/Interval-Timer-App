import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:interval_timer_app/utils/globals.dart';
import 'dart:math';

String generateRandomString(int len) {
  var r = Random();
  const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
}

class TrainingSession {
  Future<void> addNewTrainingSession(String title, String rounds,
      String trainingDuration, String breakDuration) async {
    String tsId = generateRandomString(20);
    await FirebaseFirestore.instance
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
    final QuerySnapshot qs = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('trainingSession')
        .get();

    List<DocumentSnapshot> trainingSessions = qs.docs;

    return trainingSessions;
  }
}
