import 'package:flutter/material.dart';

class TextForLoginPage extends StatelessWidget {
  // const TextForLoginPage({ Key? key }) : super(key: key);

  TextForLoginPage(this.text, double this.size, FontWeight this.weight);

  final String text;
  final double size;
  final FontWeight weight;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        text,
        style: TextStyle(
          color: Color(0xffeeeeee),
          fontSize: size,
          fontWeight: weight,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
