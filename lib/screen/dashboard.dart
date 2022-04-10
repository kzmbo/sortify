import 'package:flutter/material.dart';
import 'package:sortify/components/MainDashboard.dart';
import 'package:sortify/components/taskBarButtons.dart';
import '../components/taskBar.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({ Key? key }) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> { 
  GlobalKey mainDashboard = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          //header
          Container(
            color: Color(0xff111210),
            width: MediaQuery.of(context).size.width,
            height: 70,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Spotify Manager Platform', 
                    style: TextStyle(
                      color: Color(0xffeeeeee),
                      fontSize: 22
                    ),
                  ),

                  Container(
                    child: Row(
                      children: [
                        TextButton(onPressed: () {}, 
                          child: Text('Sign out', 
                            style: TextStyle(
                            color: Color(0xffeeeeee)
                           )
                          )
                        ),
                        SizedBox(width: 10),
                        CircleAvatar(
                          backgroundColor: Colors.pink,
                          radius: 20,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ) 
          ),// end header
          Row(
            children: [
              TaskBar(),
              MainDashboard(key: mainDashboard, currentFunction: 'Create'),
            ],
          )
        ],
      ),
    );
  }
}