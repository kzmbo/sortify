import 'package:flutter/material.dart';
import 'package:sortify/screen/LoginPage.dart';
import 'package:sortify/screen/dashboard.dart';
import 'dart:js' as js;


void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Dashboard(),
      )
    );
  }
}
