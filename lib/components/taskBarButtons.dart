import 'package:flutter/material.dart';

class TaskBarButtons extends StatelessWidget {
  //const TaskBarButtons({ Key? key }) : super(key: key);

  TaskBarButtons(this.imageURL, this.text);
  
  final String imageURL;
  final String text;

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
          Text(text, 
          style: TextStyle(
            color: Color(0xffF1F1F1),
            fontSize: 20
          )
        ),
        ],
      ),
      )
    );
  }
}