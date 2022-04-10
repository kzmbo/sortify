import 'package:flutter/material.dart';
import 'package:sortify/components/textForLoginPage.dart';
import 'package:sortify/App.dart';

final String projectName = 'SpotCleaner';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
              Color(0xff1DB954),
              Color(0xff13632F),
              Color(0xff151616)
            ])),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextForLoginPage(projectName, 65, FontWeight.w700),
            ),
            SizedBox(height: 15),
            Container(
                decoration: BoxDecoration(
                    color: Color(0xff171717),
                    border: Border.all(width: 1, color: Color(0xff171717)),
                    borderRadius:
                        const BorderRadius.all(const Radius.circular(20))),
                //
                width: 500,
                height: 650,
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextForLoginPage(
                          'Let\'s be honest...', 40, FontWeight.w300),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextForLoginPage(
                          'Spotify\'s UI is not the greatest when it comes to effectively editing your playlists. ',
                          24,
                          FontWeight.w100),
                    ),
                    SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextForLoginPage(
                          'Organizing your music has forever been a frustrating task, needing hours set aside to do. Your solution?',
                          24,
                          FontWeight.w100),
                    ),
                    SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextForLoginPage(
                          'Get sorted, use', 24, FontWeight.w100),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextForLoginPage(projectName, 40, FontWeight.w400),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: TextButton(
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
                          )),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextForLoginPage('This will open in a new window.',
                          16, FontWeight.w100),
                    ),
                    SizedBox(height: 30),
                  ],
                ))
          ],
        ));
  }
}
