import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_designs/pages/basic_design.dart';
import 'package:flutter_designs/pages/blurgrid_design.dart';
import 'package:flutter_designs/pages/scroll_design.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Force the status bar to be white
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return MaterialApp(
        title: 'Flutter Designs',
        debugShowCheckedModeBanner: false,
        initialRoute: 'blur_grid',
        routes: {
          'basic_design': (_) => BasicDesignPage(),
          'scroll_design': (_) => ScrollDesignPage(),
          'blur_grid': (_) => BlurGridDesignPage(),
        });
  }
}
