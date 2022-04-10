import 'dart:html';
import 'dart:js';

import 'package:flutter/material.dart';
import 'package:sortify/screen/LoginPage.dart';
import 'package:sortify/screen/dashboard.dart';
import 'package:sortify/App.dart';
import 'package:js/js_util.dart';

void main() {
  runApp(const SecondRoute());
  onPageLoad();

  //setProperty(window, 'callLoadDashboard', allowInterop(FirstRoute.loadDashboard));
}

class FirstRoute extends StatelessWidget {
  const FirstRoute({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(fontFamily: 'Montserrat'),
        home: const Scaffold(
          body: LoginPage(),
        ));
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(fontFamily: 'Montserrat'),
        home: const Scaffold(
          body: Dashboard(),
        ));
  }
}
