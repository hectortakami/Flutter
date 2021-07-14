// @dart=2.9

import 'package:flutter/material.dart';
import 'package:flutter_movies/pages/detail.dart';
import 'package:flutter_movies/pages/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Movies',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomePage(),
        'detail': (BuildContext context) => DetailPage(),
      },
    );
  }
}
