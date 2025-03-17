import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;

  // events
  bool getLoading() => _isLoading;

  // change isLoading value
  void changeValue() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  Future<void> userSignUp(String email, String password) async {
    try {
      changeValue();
      UserCredential? user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (user != null) {
        log("user created");
        changeValue();
      }
    } on FirebaseAuthException catch (e) {
      changeValue();
      log(e.message.toString());
    }
  }
}
