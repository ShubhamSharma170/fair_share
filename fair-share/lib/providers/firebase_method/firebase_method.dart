import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseMethodProvider extends ChangeNotifier {
  List groupNameList = [];

  // events
  // get list of group name
  List getGroupNameList() => groupNameList;

  // add expense to firebase
  Future<bool> addExpense(String description, var amount) async {
    try {
      await FirebaseFirestore.instance.collection("expense").add({
        "description": description,
        "amount": amount,
      });
      notifyListeners();
      log("expense added");
      return true;
    } on FirebaseException catch (e) {
      log(e.message.toString());
    }
    return false;
  }

  Future<bool> addGroupName(String groupName) async {
    try {
      FirebaseFirestore.instance.collection("group").add({
        "groupName": groupName,
      });
      log(("group added"));
      return true;
    } on FirebaseException catch (e) {
      log(e.message.toString());
    }
    return false;
  }

  // function for show all group name list
  Future<void> showGroupNameList() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection("group").get();
      groupNameList =
          querySnapshot.docs
              .map(
                (doc) =>
                    (doc.data() as Map<String, dynamic>)['groupName'] as String,
              )
              .toList();

      log("$groupNameList");
      notifyListeners();
    } on FirebaseException catch (e) {
      log(e.message.toString());
    }
  }
}
