import 'package:flutter/material.dart';

class TextForLoginPage extends StatelessWidget {
  // const TextForLoginPage({ Key? key }) : super(key: key); 

  TextForLoginPage(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(text, 
        style: TextStyle(
          color: Color(0xffeeeeee),
          fontSize: 30,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}