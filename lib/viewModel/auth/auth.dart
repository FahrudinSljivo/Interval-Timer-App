import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:interval_timer_app/models/userModel.dart';
import 'package:interval_timer_app/utils/globals.dart';

class Auth {
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  ///Simple method that maps provided arguments to a new UserModel class instance.
  UserModel _userFromFirebaseUser(
      auth.User user, String email, String password) {
    return user != null ? UserModel(user.uid, email, password) : null;
  }

  ///A function that returns success if there is currently signed firebase user on this device. It's used for autologin feature.
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

  ///Function that basically wraps firebase_auth createUserWithEmailAndPassword function that registers user in firebase db. Also, a new document is inserted into collection users with the passed credentials.
  ///Finally id of the registered user is set in a currentlySignedUser global variable which is used in numerous places throughout the app. If the method returns an error, print it in the console.
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

  ///Analogous to the above function - it's just signin instead of register method and there's nothing to insert in db. If the signInWithEmailAndPassword method returns an error, print it in the console.
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

  ///Function to sign out the currently signed user (uses firebase_auth signOut method). If the method returns an error, print it in the console.
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
