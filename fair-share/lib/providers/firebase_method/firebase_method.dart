import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseMethodProvider extends ChangeNotifier {
  List<String> groupNameList = [];
  String _selectedGroupName = "";

  // events
  // get method for selected group name
  String get selectedGroupName => _selectedGroupName;

  // set method for selected group name
  set selectedGroupName(String value) {
    _selectedGroupName = value;
    notifyListeners();
  }

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

  // add expenses to firebase with group name
  Future<void> addExpenseWithGroupName(
    String groupName,
    String description,
    String amount,
  ) async {
    try {
      // find group name
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance
              .collection("groupExpense")
              .where("groupName", isEqualTo: groupName)
              .limit(1)
              .get();
      if (snapshot.docs.isEmpty) {
        // setp 1: add expense
        DocumentReference docRef = await FirebaseFirestore.instance
            .collection("groupExpense")
            .add({"groupName": groupName});
        // step 2: add expense id to expense collection
        docRef.collection("expense").add({
          "description": description,
          "amount": amount,
        });
      } else {
        FirebaseFirestore.instance
            .collection("groupExpense")
            .doc(snapshot.docs.first.id)
            .collection("expense")
            .add({"description": description, "amount": amount});
      }
      log("expense added with group name");
    } on FirebaseException catch (e) {
      log("Error... ${e.message.toString()}");
    }
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
