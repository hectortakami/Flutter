import 'package:flutter/material.dart';

class UIProvider with ChangeNotifier {
  int _navtabIndex = 0;

  int get navTabIndex => _navtabIndex;

  set navTabIndex(int index) {
    _navtabIndex = index;
    notifyListeners();
  }
}
