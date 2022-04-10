import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard ({ Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> { 
  final inputController = TextEditingController();
  final List<String> options = ['Merge', 'Create', 'Split'];
  List<String> playlistTest = List<String>.generate(20, (index) => 'Song ${index + 1}');
  String? currentOption = 'Merge';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [

          //Header
          Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            color: Color.fromARGB(255, 33, 33, 33),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Title 
                  Text('Spotify Playlist Manager', style: TextStyle(color: Color(0xffeeeeee), fontSize: 33)),
                  //Sign out and avatar
                  Container(
                    child: Row(
                      children: [
                        TextButton(
                          onPressed: (){},
                          child: Text('Sign Out', style: TextStyle(color: Color(0xffeeeeee), fontSize: 22)),
                        ),
                        SizedBox(width: 10),
                        CircleAvatar(backgroundColor: Colors.pink),
                        SizedBox(width: 20),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),//end header

          //Taskbar and buttons
          Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            color: Color.fromARGB(255, 42, 42, 42),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                //Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //by mood
                    OutlinedButton(
                      onPressed: (){}, 
                      child: Text('By mood')
                    ),//end by mood

                    SizedBox(width: 10),

                    //by Artist
                    OutlinedButton(
                      onPressed: (){}, 
                      child: Text('By Artist')
                    ),//end by Artist

                    SizedBox(width: 10),

                    //by genre
                    OutlinedButton(
                      onPressed: (){}, 
                      child: Text('By Genre')
                    ),//end by genre

                    SizedBox(width: 10),

                    //by language
                    OutlinedButton(
                      onPressed: (){}, 
                      child: Text('By Language')
                    ),//end by language
                  ],
                ),//end buttons
                SizedBox(height: 10),

                //input text field
                Container(
                  width: 250,
                  child: TextField(
                    controller: inputController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter text',
                      labelStyle: TextStyle(color: Color(0xffeeeeee), fontSize: 15),
                    ),
                  ),
                ), // end input field
              ],
            ),
          ), // end taskbar

          //start playlist display
          Container(
            width: MediaQuery.of(context).size.width,
            height: 300,
            color: Color.fromARGB(255, 52, 52, 52),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Playlist thumbnail, title, and desc
                  Container(
                    height: 200,
                    child: Row(
                      children: [
                        Image(image: NetworkImage('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'), width: 200,),
                        SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Playlist #1', style: TextStyle(color: Color(0xffeeeeee), fontSize: 22), textAlign: TextAlign.left),
                            SizedBox(height: 6),
                            Text('Lorem doailjfksjdlkfsaklfslk', style: TextStyle(color: Color(0xffeeeeee), fontSize: 14), textAlign: TextAlign.left),
                          ],
                        )
                      ],
                    ),
                  ),// end playlist

                  //Select function to playlist
                  Container(
                    height: 200,
                    child: Column(
                      children: [
                        //Playlist preview
                        Row(
                          children: [
                            Image(image: NetworkImage('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'), width: 100,),
                            SizedBox(width: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Playlist #1', style: TextStyle(color: Color(0xffeeeeee), fontSize: 22), textAlign: TextAlign.left),
                              ],
                            ),
                            SizedBox(width: 50)
                          ],
                        ),// end playlist preview
                        SizedBox(height: 10),
                        //Drop Drop Menu
                        Container(
                          width: 250,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DropdownButton<String>(
                                value: currentOption,
                                items: options.map((option) => DropdownMenuItem<String>(
                                  value: option,
                                  child: Text(option, style: TextStyle(color: Color(0xffeeeeee))),
                                )).toList(),  
                                onChanged: (item) => setState(() => currentOption = item),
                              ),
                              //POST to spotify based on what is selected
                              TextButton(
                                onPressed: (){}, 
                                child: Text('Go!', style: TextStyle(color: Color(0xffeeeeee)))
                              ),
                              SizedBox(width: 20)
                            ],
                          ),
                        )// end drop down
                      ],
                    ),
                  ), // end select function for playlist
                ],
              )
            )
          ),//end playlist display
          
          //list of all songs
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: double.infinity,
              color: Color.fromARGB(255, 52, 52, 52),
              child: ListView.builder(
                itemCount: playlistTest.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Container(
                      width: MediaQuery.of(context).size.width,
                      //height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        border: Border( top: BorderSide(width: 1.0, color: Color.fromARGB(255, 180, 180, 180), style: BorderStyle.solid)),
                      ),
                      child: Text(playlistTest[index], style: TextStyle(color: Color.fromARGB(255, 180, 180, 180)))
                    )
                  );
                }
              ),
            )
          )

        ],
      ),
    );
  }
}