import 'package:flutter/material.dart';
import 'package:flutter_qrscanner_sqlite/pages/home.dart';
import 'package:flutter_qrscanner_sqlite/providers/db_provider.dart';
import 'package:flutter_qrscanner_sqlite/providers/ui_provider.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UiProvider()),
        ChangeNotifierProvider(create: (_) => DBProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QRScanner SQLite',
        initialRoute: 'home',
        routes: {'home': (_) => HomePage()},
        theme: ThemeData(
          primaryColor: Colors.teal,
          floatingActionButtonTheme:
              FloatingActionButtonThemeData(backgroundColor: Colors.teal),
        ),
      ),
    );
  }
}
