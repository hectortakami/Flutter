import 'package:firebase_forms/pages/home_page.dart';
import 'package:firebase_forms/pages/login_page.dart';
import 'package:firebase_forms/providers/form_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FormProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Firebase Forms',
        initialRoute: 'login',
        routes: {
          'home': (_) => HomePage(),
          'login': (_) => LoginPage(),
        },
        theme: ThemeData.light()
            .copyWith(scaffoldBackgroundColor: Colors.grey[300]),
      ),
    );
  }
}
