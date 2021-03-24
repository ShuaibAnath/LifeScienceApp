import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:ls_app_firebase_login/screens/dummy_screen.dart';
import 'package:ls_app_firebase_login/screens/requiredInfo_screen.dart';
import 'package:provider/provider.dart';
import 'login_screen.dart';
import 'package:ls_app_firebase_login/compontents/rounded_button.dart';
import 'package:ls_app_firebase_login/auth_bloc.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  //static allows you to access the attribute directly from the class without instantiating an object of the class.
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  StreamSubscription<User> loginStateSubscription;
  @override
  void initState() {
    var authBloc = Provider.of<AuthBloc>(context, listen: false);
    loginStateSubscription = authBloc.currentUser.listen((fbUser) {
      // if (fbUser != null) {
      //   Navigator.of(context).pushReplacement(
      //     MaterialPageRoute(
      //       builder: (context) => DummyScreen(),
      //     ),
      //   );
      // } // check if firebase user exists
    });
    super.initState();
  }

  @override
  void dispose() {
    loginStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = Provider.of<AuthBloc>(context);
    return Scaffold(
      backgroundColor: Color(0xFF264653),
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
              colour: Color(0xFFE9C46A),
              title: 'Log In',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
            ), //onPressed - Go to login screen.
            RoundedButton(
              colour: Color(0xFFE9C46A),
              title: 'Register',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RequiredInfoScreen()),
                );
              },
            ),
            SignInButton(Buttons.Google,
                elevation: 5.0, text: 'Sign out with Google', onPressed: () {
              authBloc.logout();
            }),
          ],
        ),
      ),
    );
  }
}
