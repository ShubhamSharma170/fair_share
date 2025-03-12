import 'package:flutter/material.dart';

class ListMapProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _listMap = [];

  // events
  List<Map<String, dynamic>> getList() => _listMap;

  addData(Map<String, dynamic> data) {
    _listMap.add(data);
    notifyListeners();
  }
}
