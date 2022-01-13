// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class LoginBackground extends StatelessWidget {
  final Widget child;

  const LoginBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          _indigoContainer(media),
          _headerIcon(),
          child,
        ],
      ),
    );
  }

  Widget _headerIcon() {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 30),
        child: const Icon(
          Icons.person_pin,
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }

  Widget _indigoContainer(Size media) {
    return Container(
      width: double.infinity,
      height: media.height * 0.4,
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromRGBO(63, 63, 156, 1),
        Color.fromRGBO(90, 70, 178, 1),
      ])),
      child: Stack(
        children: [
          Positioned(child: _bubble(), top: 90, left: 30),
          Positioned(child: _bubble(), top: -40, left: -30),
          Positioned(child: _bubble(), top: -50, right: -20),
          Positioned(child: _bubble(), bottom: -50, left: 10),
          Positioned(child: _bubble(), bottom: 120, right: 20),
        ],
      ),
    );
  }

  Widget _bubble() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: const Color.fromRGBO(255, 255, 255, 0.05),
      ),
    );
  }
}
