import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseMethodProvider extends ChangeNotifier {
  // events
  // add expense to firebase
  void addExpense(String description, var amount) async {
    try {
      await FirebaseFirestore.instance.collection("expense").add({
        "description": description,
        "amount": amount,
      });
      notifyListeners();
      log("expense added");
    } on FirebaseException catch (e) {
      log(e.message.toString());
    }
  }
}
