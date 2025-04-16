// ignore_for_file: unnecessary_null_comparison

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProviderClass extends ChangeNotifier {
  bool _isLoading = false;
  bool _isGoogleLoading = false;

  // events
  bool getLoading() => _isLoading;
  bool getGoogleLoading() => _isGoogleLoading;

  // change isLoading value
  void changeValue() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  // change isGoogleLoading value
  void changeGoogleValue() {
    _isGoogleLoading = !_isGoogleLoading;
    notifyListeners();
  }

  // method for sign up
  Future<bool> userSignUp(String email, String password) async {
    try {
      changeValue();
      UserCredential? user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (user != null) {
        log("user created");
        log("user details ${user.user!}");
        changeValue();
        return true;
      } else {
        log("user not created");
        changeValue();
        return false;
      }
    } on FirebaseAuthException catch (e) {
      changeValue();
      log(e.message.toString());
      return false;
    }
  }

  // method for sign in
  Future<bool> signIn(String email, String password) async {
    try {
      changeValue();
      UserCredential? user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (user != null) {
        log("user signed in");
        log("user details ${user.user!}");
        changeValue();
        return true;
      } else {
        log("user not signed in");
        changeValue();
        return false;
      }
    } on FirebaseException catch (e) {
      changeValue();
      log(e.message.toString());
      return false;
    }
  }

  // method for google sign in
  Future<bool> googleSignIn() async {
    try {
      changeGoogleValue();
      GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();
      if (googleSignInAccount != null) {
        log("google user details $googleSignInAccount");
        changeGoogleValue();
        return true;
      }
    } on FirebaseException catch (e) {
      log("${e.message}");
    }
    changeGoogleValue();
    return false;
  }
}
