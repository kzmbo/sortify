import 'package:flutter/material.dart';
import 'package:sortify/components/taskBarButtons.dart';

class TaskBar extends StatefulWidget {
  const TaskBar({ Key? key }) : super(key: key);

  @override
  State<TaskBar> createState() => _TaskBarState();
}

class _TaskBarState extends State<TaskBar> {
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
                TaskBarButtons(imageURL: './../icons/add.png', text: 'Create Playlist'),
                TaskBarButtons(imageURL: './../icons/add.png', text: 'Merge Playlist'),
                TaskBarButtons(imageURL: './../icons/add.png', text: 'Split Playlist'),
                SizedBox(height: 10),
                //Text('Button1 is ${(createButtonKey.currentState as TaskBarButtons).isPressed.toString()}')
              ],
            ),
          ),
    );
  }
}
