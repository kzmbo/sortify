import 'package:flutter/material.dart';
import 'package:sortify/components/EditTaskBar.dart';
import 'package:sortify/components/Playlist.dart';

class MainDashboard extends StatefulWidget {
  MainDashboard({ Key? key,  required this.currentFunction}) : super(key: key);
  String currentFunction; 

  @override
  State<MainDashboard> createState() => _MainDashboardState(currentFunction);
}

class _MainDashboardState extends State<MainDashboard> {
  _MainDashboardState(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    Widget _editTaskBar = EditTaskBar(text: text);
    Widget _Playlist = Playlist(text: text);

    return Container(
      width: MediaQuery.of(context).size.width - 275, 
      height: MediaQuery.of(context).size.height - 70,
      color: Color(0xff242424),
      child: Column(
        children: [
          _editTaskBar,
          _Playlist
        ],
      ),
    );
  }
}