import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  String _currentMenu = 'Home';

  String get currentMenu => _currentMenu;

  void setCurrentMenu(String menu) {
    _currentMenu = menu;
    notifyListeners();
  }
}
