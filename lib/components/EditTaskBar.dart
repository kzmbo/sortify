import 'package:flutter/material.dart';


class EditTaskBar extends StatefulWidget {
  String text;
  EditTaskBar({ Key? key, required this.text }) : super(key: key);

  @override
  State<EditTaskBar> createState() => _EditTaskBarState(text);
}

class _EditTaskBarState extends State<EditTaskBar> {
  _EditTaskBarState(this.text);
  String text;

  final inputTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (text == "Create"){
      return Container(
        width: MediaQuery.of(context).size.width,
        color: Color.fromARGB(255, 76, 76, 76),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Edit ${text} Playlist', style: TextStyle(color: Color(0xffeeeeee), fontSize: 20)),
              Column(
                children: [
                  //Rows for the buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(onPressed: () {}, 
                        style: ButtonStyle(
                        //minimumSize: MaterialStateProperty.all(10),
                        backgroundColor: MaterialStateProperty.all<Color>(Color(0xff1DB954)),
                        foregroundColor: MaterialStateProperty.all<Color>(Color(0xffeeeeee)),
                        ),
                        child: Text('By Mood')
                      ),
                      SizedBox(width: 10),
                      TextButton(onPressed: () {}, 
                        style: ButtonStyle(
                        //minimumSize: MaterialStateProperty.all(10),
                        backgroundColor: MaterialStateProperty.all<Color>(Color(0xff1DB954)),
                        foregroundColor: MaterialStateProperty.all<Color>(Color(0xffeeeeee)),
                        ),
                        child: Text('By Artist')
                      ),
                      SizedBox(width: 10),
                      TextButton(onPressed: () {}, 
                        style: ButtonStyle(
                        //minimumSize: MaterialStateProperty.all(10),
                        backgroundColor: MaterialStateProperty.all<Color>(Color(0xff1DB954)),
                        foregroundColor: MaterialStateProperty.all<Color>(Color(0xffeeeeee)),
                        ),
                        child: Text('By Genre')
                      ),
                      SizedBox(width: 10),
                      TextButton(onPressed: () {}, 
                        style: ButtonStyle(
                        //minimumSize: MaterialStateProperty.all(10),
                        backgroundColor: MaterialStateProperty.all<Color>(Color(0xff1DB954)),
                        foregroundColor: MaterialStateProperty.all<Color>(Color(0xffeeeeee)),
                        ),
                        child: Text('By Language')
                      )
                    ],
                  ),
                  //end button rows
                  SizedBox(height: 10),
                  Container(              
                    width: 340,
                    child: TextField(
                      controller: inputTextController,                                 
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xffeeeeee), width: 0.0),
                        ),
                        labelText: 'Enter data',
                        labelStyle: TextStyle(
                          color: Color(0xffeeeeee)
                        )
                      ),
                    )
                  )
                ],
              ),
            ],
          ),
        ) 
      );
    } else {
      return Container(
        child: TextField(
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter a search term',
            ),
        ),
      );
    };
  }
}