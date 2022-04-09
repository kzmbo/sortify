import 'package:flutter/material.dart';
import 'package:sortify/components/textForLoginPage.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            color: Color(0xff171717),
            width: 500,
            height: 600,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextForLoginPage('Let\'s be honest'), 
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextForLoginPage('Spotify\'s UI is not the greatest when it comes to effectively editing your playlists. '), 
                ),
                SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextForLoginPage('Organizing your music has forever been a frustrating task, needing hours set aside to do. Your solution?'), 
                ),
                SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextForLoginPage('Get sorted with'), 
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextForLoginPage('--title--'), 
                ),
                SizedBox(height: 10),
                TextButton(
                  style: ButtonStyle(
                    //minimumSize: MaterialStateProperty.all(10),
                    backgroundColor: MaterialStateProperty.all<Color>(Color(0xff1DB954)),
                    foregroundColor: MaterialStateProperty.all<Color>(Color(0xffeeeeee)),
                  ),
                  onPressed: () { },
                  child: Text('Login with Spotify'),
                )
              ],
            )
          )
        ],
      )
    );
  }
}