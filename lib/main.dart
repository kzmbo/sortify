import 'package:flutter/material.dart';
import 'package:sortify/screen/LoginPage.dart';
import 'package:sortify/screen/dashboard.dart';
import 'package:sortify/App.dart';

void main() {
  runApp(const MyApp());
  onPageLoad();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(fontFamily: 'Montserrat'),
        home: const Scaffold(
          //body: LoginPage(),
          body: Dashboard(),
        ));
  }
}
