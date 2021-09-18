import 'package:flutter/material.dart';

class LoadInButton with ChangeNotifier {
  // Init value
  bool load = false;

  void turnOnLoading(){
    load = true;
    notifyListeners();
  }
  void turnOffLoading(){
    load = false;
    notifyListeners();
  }

}