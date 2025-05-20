import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

class CustomMethodProvider extends ChangeNotifier {
  bool checkLoading = false;

  // events

  // get value
  bool getLoading() => checkLoading;

  // change value
  void resetLoadingValue() {
    checkLoading = false;
    notifyListeners();
  }

  // change value after 2 seconds
  changeValue() {
    Timer(Duration(seconds: 2), () {
      checkLoading = true;
      log("check loading $checkLoading");
      notifyListeners();
    });
  }
}
