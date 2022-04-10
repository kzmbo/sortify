import 'package:flutter/material.dart';


class Playlist extends StatefulWidget {
  String text;
  Playlist({ Key? key, required this.text }) : super(key: key);

  @override
  State<Playlist> createState() => _PlaylistState(text);
}

class _PlaylistState extends State<Playlist> {
  _PlaylistState(this.text);
  String text;
  String dropdownValue = 'Playlist #1'; 
  List<String> playlistList = List<String>.generate(20, (i) => 'Song $i');

  @override
  Widget build(BuildContext context) {
    List<String> items = ['playlist1', 'playlist2'];
    String? selectedItem = items[0];
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Color.fromARGB(255, 50, 50, 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //drop down menu
          Container(
            color: Colors.green,
            child: DropdownButton<String>(
              value: selectedItem,
              items: items
              .map((item) => DropdownMenuItem<String>(
                value: item, 
                child: Text(item, style: TextStyle(fontSize: 20)),
                )).toList(),
                onChanged: (item) => setState(() {
                  selectedItem = item;
                }),
            ),
          ),//end drop down menu
          SizedBox(height: 10),

          //Start Playlist picture, title, desc
          Container(
            child: Row(
              children: [
                SizedBox(width: 10),
                Image(image: NetworkImage('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'), width: 200,),
                SizedBox(width: 10),
                Column(
                  children: [
                    Text('Playlist Name', style: TextStyle(fontSize: 30, color: Color(0xffeeeeee)),),
                    SizedBox(height: 10),
                    Text('Playlist description', style: TextStyle(fontSize: 15, color: Color(0xffeeeeee)),)
                  ],
                )
              ],
            ),
          ),// end playlist
          SizedBox(height: 20),

          //song list
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 500,
            child: ListView.builder(
              itemCount: playlistList.length,
              itemBuilder: (context, index){
                return ListTile(
                  title: Text('${index}. ${playlistList[index]}', style: TextStyle(color: Color(0xffeeeeee)),),
                );
              }
            ),
          )
        ],
      ),
    );
  }
}