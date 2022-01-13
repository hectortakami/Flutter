import 'package:flutter/material.dart';

class CustomInputDecorations {
  static InputDecoration customInputDecoration({
    required String hintText,
    required String labelText,
    required IconData iconName,
  }) {
    return InputDecoration(
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.indigo,
        ),
      ),
      focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.indigo, width: 2)),
      hintText: hintText,
      labelText: labelText,
      labelStyle: const TextStyle(color: Colors.grey),
      prefixIcon: Icon(
        iconName,
        color: Colors.indigo,
      ),
    );
  }
}
