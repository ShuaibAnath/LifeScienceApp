import 'package:flutter/material.dart';
import 'package:ls_app_firebase_login/screens/requiredInfo_screen.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'package:ls_app_firebase_login/compontents/rounded_button.dart';
//ANIMATIONS
//two hero widgets
//a shared property
//navigator based screen transition
//CUSTOM ANIMATIONS
//a ticker - clock that allows animation to change over time
//an animation controller - how long etc
//animation value - does the actual animating

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  //static allows you to access the attribute directly from the class without instantiating an object of the class.
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
                  ),
                ),
              ],
            ),

            RoundedButton(
              colour: Colors.lightBlue,
              title: 'Log In',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
            ), //onPressed - Go to login screen.
            RoundedButton(
              colour: Colors.lightBlue,
              title: 'Register',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RequiredInfoScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
