import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:interval_timer_app/utils/globals.dart';
import 'dart:math';
import 'package:http/http.dart' as http;

///Generate a random string of provided length. It's used for generating unique training session IDs in db.
String generateRandomString(int len) {
  var r = Random();
  const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
}

///Function that checks if a string contains only numbers and no other characters.
bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return int.tryParse(s) != null;
}

///Simple function that returns a future (result of an asynchronous operation) - used to get all the data from a website defined with the specified URL. We return the body of the response - the content of the webpage.

Future<String> fetchTheQuote() async {
  String url = 'https://pastebin.com/raw/jmhKjPLD';
  final response = await http.get(url);

  return response.body;
}

class TrainingSessionViewModel {
  final dbInstance = FirebaseFirestore.instance;

  ///Method to add new training session to firestore using provided arguments
  Future<void> addNewTrainingSession(String tsId, String title, String rounds,
      String trainingDuration, String breakDuration) async {
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

  ///Method to fetch all training sessions of the given user.
  Future<List<DocumentSnapshot>> fetchTrainingSessions(String userId) async {
    final QuerySnapshot qs = await dbInstance
        .collection('users')
        .doc(userId)
        .collection('trainingSessions')
        .get();

    List<DocumentSnapshot> trainingSessions = qs.docs;

    return trainingSessions;
  }

  ///Method to delete a training session in the firestore based on the given user and id of the document.
  Future<void> deleteTrainingSession(String userId, String id) async {
    await dbInstance
        .collection('users')
        .doc(userId)
        .collection('trainingSessions')
        .doc(id)
        .delete();
  }
}
