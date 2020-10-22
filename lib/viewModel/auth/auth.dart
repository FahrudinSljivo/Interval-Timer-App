import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:interval_timer_app/models/userModel.dart';
import 'package:interval_timer_app/utils/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  UserModel _userFromFirebaseUser(
      auth.User user, String email, String password) {
    return user != null ? UserModel(user.uid, email, password) : null;
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      auth.UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      auth.User user = result.user;
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'id': user.uid,
        'email': email,
        'password': password,
      });
      currentlySignedUser = result.user.uid;
      final SharedPreferences prefs = await _prefs;
      prefs.setString("id", currentlySignedUser);
      print("CURRENTLY SIGNED USER");
      print(currentlySignedUser);
      return _userFromFirebaseUser(user, email, password);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      auth.UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      auth.User user = result.user;
      currentlySignedUser = result.user.uid;
      final SharedPreferences prefs = await _prefs;
      prefs.setString("id", currentlySignedUser);
      print("CURRENTLY SIGNED USER");
      print(currentlySignedUser);
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      final SharedPreferences prefs = await _prefs;
      prefs.clear();
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
