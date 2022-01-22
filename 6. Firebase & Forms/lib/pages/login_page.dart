// ignore_for_file: use_key_in_widget_constructors

import 'package:firebase_forms/providers/form_provider.dart';
import 'package:firebase_forms/shared/login_background.dart';
import 'package:firebase_forms/shared/utils/input_decorations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginBackground(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 200),
              CardContainer(child: FormFields()),
              const SizedBox(height: 25),
              const Text(
                'Create new account',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.indigo),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

class FormFields extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<LoginFormProvider>(context);

    return Form(
      key: formProvider.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            onChanged: (value) => formProvider.email,
            keyboardType: TextInputType.emailAddress,
            decoration: CustomInputDecorations.customInputDecoration(
                hintText: "john@doe.com",
                labelText: "Email Address",
                iconName: Icons.alternate_email_sharp),
            validator: (value) {
              String pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp = RegExp(pattern);
              return regExp.hasMatch(value ?? '') ? null : 'Not valid email';
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            obscureText: true,
            autocorrect: false,
            onChanged: (value) => formProvider.password,
            decoration: CustomInputDecorations.customInputDecoration(
                hintText: "**************",
                labelText: "Password",
                iconName: Icons.lock_sharp),
            validator: (value) => (value != null && value.length >= 6)
                ? null
                : 'Min password length not matched',
          ),
          const SizedBox(height: 25),
          MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            elevation: 0,
            color: Colors.indigo,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              child: Text(
                formProvider.loginIsLoading ? 'Please wait...' : 'Login',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            // To disable button, onPress must be set to null
            onPressed: formProvider.loginIsLoading
                ? null
                : () async {
                    // Hides keyboard
                    FocusScope.of(context).unfocus();
                    if (!formProvider.isFormValid()) return;
                    formProvider.loginIsLoading = true;
                    await Future.delayed(const Duration(seconds: 2));
                    formProvider.loginIsLoading = false;
                    Navigator.pushReplacementNamed(context, 'home');
                  },
          ),
        ],
      ),
    );
  }
}

class CardContainer extends StatelessWidget {
  final Widget child;

  const CardContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12, blurRadius: 15, offset: Offset(0, 5))
            ]),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text(
              'Login',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(height: 25),
            child,
          ],
        ),
      ),
    );
  }
}
