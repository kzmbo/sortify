import 'package:flutter/material.dart';
import 'package:sortify/components/taskBarButtons.dart';

class TaskBar extends StatelessWidget {
  const TaskBar({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xff1B1B1B),
        height: MediaQuery.of(context).size.height - 70,
        width: 275,
        child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            TaskBarButtons('./../icons/add.png', 'Create Playlist'),
            TaskBarButtons('./../icons/add.png', 'Merge Playlist'),
            TaskBarButtons('./../icons/add.png', 'Split Playlist'),
            SizedBox(height: 10),
            TaskBarButtons('./../icons/add.png', 'Playlist #1')
          ],
        ),
      )
    );
  }
}