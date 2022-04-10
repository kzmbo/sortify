import 'package:flutter/material.dart';
import 'package:sortify/App.dart';

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

  double _currentSliderValue = 20;
  Widget addSlider(){
    return Slider(
      value: _currentSliderValue,
      max: 100,
      divisions: 5,
      label: _currentSliderValue.round().toString(),
      onChanged: (double value) {
        setState(() {
          _currentSliderValue = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          //button
          TextButton(
            style: ButtonStyle(
              //minimumSize: MaterialStateProperty.all(10),
              backgroundColor: MaterialStateProperty.all<Color>(
                  Color(0xff1DB954)),
              foregroundColor: MaterialStateProperty.all<Color>(
                  Color(0xffeeeeee)),
            ),
            onPressed: () => requestAuth(),
            child: const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Login with Spotify',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            )
          ),

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
                      onPressed: (){setAttribute('artist', 0, 0);}, 
                      child: Text('By Artist')
                    ),//end by mood

                    SizedBox(width: 10),

                    //by Artist
                    OutlinedButton(
                      onPressed: (){setAttribute('danceability', 0, 1);}, 
                      child: Text('By Danceability')
                    ),//end by Artist

                    SizedBox(width: 10),

                    //by genre
                    OutlinedButton(
                      onPressed: (){
                        setAttribute('energy', 0, 1);
                        addSlider();
                      }, 
                      child: Text('By Energy')
                    ),//end by genre

                    SizedBox(width: 10),

                    //by language
                    OutlinedButton(
                      onPressed: (){setAttribute('Genre', 0, 0);}, 
                      child: Text('By Genre')
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
                        Image(image: NetworkImage('https://de-production.imgix.net/colors/browser/dea104.jpg'), width: 200,),
                        SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Playlist #1', style: TextStyle(color: Color(0xffeeeeee), fontSize: 22), textAlign: TextAlign.left),
                            SizedBox(height: 6),
                            Text('Playlist desc', style: TextStyle(color: Color(0xffeeeeee), fontSize: 14), textAlign: TextAlign.left),
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
                            Image(image: NetworkImage('https://de-production.imgix.net/colors/browser/dea104.jpg'), width: 100,),
                            SizedBox(width: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Playlist #2', style: TextStyle(color: Color(0xffeeeeee), fontSize: 22), textAlign: TextAlign.left),
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