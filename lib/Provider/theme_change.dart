import 'package:flutter/material.dart';

class ThemeChangeData extends ChangeNotifier {
  bool themeChange = true;

  bool get changeValue => themeChange;

  void getThemeChange() {
    themeChange = !themeChange;
    notifyListeners();
  }
}
