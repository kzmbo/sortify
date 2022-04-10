import 'package:flutter/material.dart';
import 'package:sortify/screen/LoginPage.dart';
import 'package:sortify/screen/dashboard.dart';

class TaskBarButtons extends StatefulWidget {
  String imageURL;
  String text;
  TaskBarButtons({ Key? key, required this.imageURL, required this.text}) : super(key: key);
  _TaskBarButtonsState createState() => _TaskBarButtonsState(text, imageURL);
}

class _TaskBarButtonsState extends State<TaskBarButtons> {
  _TaskBarButtonsState(this.text, this.imageURL);
  final String text; 
  final String imageURL;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image(
            width: 50,
            image: NetworkImage('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg')
          ),
          SizedBox(width: 5),
          TextButton(
            onPressed: () {
               Navigator.pushReplacement(
                context, 
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) => LoginPage(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              textStyle: TextStyle(fontSize: 20, color: Color(0xffF1F1F1)), 
            ),
            child: Text(text, style: TextStyle(color: Color(0xffF1F1F1)),),
          ),
        ],
      ),
      )
    );
  }
}