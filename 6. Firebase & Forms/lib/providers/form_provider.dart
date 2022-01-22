import 'package:firebase_forms/models/product.dart';
import 'package:flutter/material.dart';

// HANDLES LOGIN FORM FIELD PROPERTIES
class LoginFormProvider extends ChangeNotifier {
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

// HANDLES PRODUCT FORM FIELD PROPERTIES
class ProductFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late ProductModel product;
  bool isNewProduct = false;
  bool isPictureChanged = false;

  set productPicture(String imagePath) {
    product.picture = imagePath;
    notifyListeners();
  }

  set productAvailability(bool value) {
    product.available = value;
    notifyListeners();
  }

  bool isFormValid() {
    return formKey.currentState?.validate() ?? false;
  }
}
