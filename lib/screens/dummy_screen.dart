import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:ls_app_firebase_login/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:ls_app_firebase_login/screens/login_screen.dart';
import 'package:provider/provider.dart';

class DummyScreen extends StatefulWidget {
  static const String id = 'dummy_screen';
  @override
  _DummyScreenState createState() => _DummyScreenState();
}

class _DummyScreenState extends State<DummyScreen> {
  StreamSubscription<User> loginStateSubscription;

  @override
  void initState() {
    var authBloc = Provider.of<AuthBloc>(context, listen: false);
     loginStateSubscription = authBloc.currentUser.listen((fbUser) {
      if (fbUser == null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      } // check if firebase user exists
    });
    super.initState();
  }//init state to Logout


  @override
  void dispose() {
    loginStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = Provider.of<AuthBloc>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: SignInButton(Buttons.Google,
              elevation: 5.0,
              text: 'Sign out with Google',
              onPressed: () =>authBloc.logout(),
        ),
        ),
      ],
    );
  }
}//class DummyScreen
