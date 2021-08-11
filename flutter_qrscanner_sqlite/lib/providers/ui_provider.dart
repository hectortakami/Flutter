import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier {
  int _menuOpt = 0;

  int get menuOpt {
    return this._menuOpt;
  }

  set menuOpt(int i) {
    this._menuOpt = i;
    notifyListeners();
  }
}
