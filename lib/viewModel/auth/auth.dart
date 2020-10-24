import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:interval_timer_app/models/userModel.dart';
import 'package:interval_timer_app/utils/globals.dart';

class Auth {
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  UserModel _userFromFirebaseUser(
      auth.User user, String email, String password) {
    return user != null ? UserModel(user.uid, email, password) : null;
  }

  Future<String> currentUser() async {
    String ret = "error";

    try {
      auth.User firebaseUser = await _auth.currentUser;
      currentlySignedUser = firebaseUser.uid;
      ret = "success";
    } catch (e) {
      print(e);
    }

    return ret;
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
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
