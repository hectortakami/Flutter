// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/pages/home_page.dart';
import 'package:qr_scanner/pages/map_page.dart';
import 'package:qr_scanner/providers/sql_provider.dart';
import 'package:qr_scanner/providers/ui_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UIProvider()),
        ChangeNotifierProvider(create: (_) => SQLProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QR Scanner',
        initialRoute: 'home',
        routes: {
          'home': (_) => const HomePage(),
          'map': (_) => MapPage(),
        },
        theme: ThemeData.dark().copyWith(
          floatingActionButtonTheme:
              ThemeData.dark().floatingActionButtonTheme.copyWith(
                    backgroundColor: Colors.deepOrange,
                  ),
          bottomNavigationBarTheme:
              ThemeData.dark().bottomNavigationBarTheme.copyWith(
                    selectedItemColor: Colors.deepOrange,
                  ),
        ),
      ),
    );
  }
}
