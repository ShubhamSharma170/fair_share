import 'package:flutter/material.dart';

class CounterProvider extends ChangeNotifier{
  int _count = 0;

  int getCounter() => _count;

  void incrementEvent(){
    _count++;
    notifyListeners();
  }

  void decrementEvent(){
    if(_count>0)
    {
    _count++;
    notifyListeners();
    }
  }
}