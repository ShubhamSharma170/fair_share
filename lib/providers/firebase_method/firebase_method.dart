import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseMethodProvider extends ChangeNotifier {
  List<String> groupNameList = [];
  List<String> userNameList = [];
  List<String> selectedUserNameList = [];
  List<String> selectedGroupNameList = [];
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

  // get list of user name
  List getUserNameList() => userNameList;

  // get list of selected user name
  List<String> getSelectedUserNameList() => selectedUserNameList;

  // get list of selected group name
  List getSelectedGroupNameList() => selectedGroupNameList;

  // add expense to firebase
  Future<bool> addExpense(String description, var amount) async {
    try {
      await FirebaseFirestore.instance.collection("expense").add({
        "description": description,
        "amount": amount,
      });
      // await FirebaseFirestore.instance.collection("expense").add({
      //   "description": description,
      //   "amount": amount,
      // });
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
    String uid,
  ) async {
    try {
      String name = await findUserName(uid);
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
          "name": name,
        });
      } else {
        FirebaseFirestore.instance
            .collection("groupExpense")
            .doc(snapshot.docs.first.id)
            .collection("expense")
            .add({"description": description, "amount": amount, "name": name});
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

  // method for log out
  Future<bool> logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      log('log out successfully.....');
      return true;
    } on FirebaseException catch (e) {
      log("Error is.......${e.message}");
      return false;
    }
  }

  // method for save user details
  Future<void> saveUserDetails(
    String name,
    String email,
    String password,
    String uid,
  ) async {
    try {
      FirebaseFirestore.instance.collection("users").add({
        "name": name,
        "email": email,
        "password": password,
        "uid": uid,
      });
      log("user details saved");
    } on FirebaseException catch (e) {
      log("Error is.......${e.message}");
    }
  }

  // method for find user names
  Future<String> findUserName(String uid) async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance
              .collection("users")
              .where("uid", isEqualTo: uid)
              .get();
      if (snapshot.docs.isNotEmpty) {
        Map<String, dynamic> data =
            snapshot.docs.first.data() as Map<String, dynamic>;
        log("snapshort ${data["name"]}");
        return data["name"];
      }
      return "";
    } on FirebaseException catch (e) {
      log("Error is.......${e.message}");
      return "";
    }
  }

  // method for show all user name list
  Future<void> showUserNameList() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection("users").get();

      userNameList =
          querySnapshot.docs
              .map(
                (doc) => (doc.data() as Map<String, dynamic>)['name'] as String,
              )
              .toList();
      log("user name list $userNameList");
      notifyListeners();
    } on FirebaseException catch (error) {
      log("Error is.......${error.message}");
    }
  }

  // method for add user in group
  addUserInGroup(List<String> userList, String groupName) async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance
              .collection("group")
              .where("groupName", isEqualTo: groupName)
              .limit(1)
              .get();

      if (snapshot.docs.isNotEmpty) {
        FirebaseFirestore.instance
            .collection("group")
            .doc(snapshot.docs.first.id)
            .update({"users": FieldValue.arrayUnion(userList)});
        selectedUserNameList = userList;
        notifyListeners();
        log("user added in group");
      }
    } on FirebaseException catch (e) {
      log("Error is.......${e.message}");
    }
  }

  // method for show only group name where users are added
  Future<void> showGroupNameOnly(String userName) async {
    try {
      selectedGroupNameList.clear();
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('group').get();
      if (snapshot.docs.isNotEmpty) {
        for (var doc in snapshot.docs) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          if (data['users'] != null && data["users"].contains(userName)) {
            selectedGroupNameList.add(data["groupName"]);
          }
        }
        log("data $selectedGroupNameList}");
        notifyListeners();
      }
    } on FirebaseException catch (e) {
      log("Error is.......${e.message}");
    }
  }
}
