import 'package:flutter/material.dart';
import 'package:sortify/screen/LoginPage.dart';
import 'package:sortify/screen/dashboard.dart';
import 'package:sortify/App.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home: Scaffold(
      body: LoginPage(), // Dashboard(),
    ));
  }
}
