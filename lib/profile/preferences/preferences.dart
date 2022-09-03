import 'package:flutter/material.dart';

class PreferencesModel with ChangeNotifier {
  int radius = 3000;

  void setRadius(int radius) {
    this.radius = radius;
    notifyListeners();
  }
}