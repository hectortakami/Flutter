import 'package:flutter/material.dart';

class FormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  bool _loginResponseIsLoading = false;
  bool get loginIsLoading => _loginResponseIsLoading;
  set loginIsLoading(value) {
    _loginResponseIsLoading = value;
    notifyListeners();
  }

  bool isFormValid() {
    return formKey.currentState?.validate() ?? false;
  }
}
