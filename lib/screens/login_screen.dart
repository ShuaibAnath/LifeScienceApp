import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ls_app_firebase_login/compontents/rounded_button.dart';
import 'package:ls_app_firebase_login/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ls_app_firebase_login/screens/dummy_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'welcome_screen.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:ls_app_firebase_login/auth_bloc.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  StreamSubscription<User> loginStateSubscription;
  // create a listener for google sign in
  // @override
  // void initState() {
  //   var authBloc = Provider.of<AuthBloc>(context, listen: false);
  //   loginStateSubscription = authBloc.currentUser.listen((fbUser) {
  //     if (fbUser != null) {
  //       Navigator.of(context).pushReplacement(
  //         MaterialPageRoute(
  //           builder: (context) => DummyScreen(),
  //         ),
  //       );
  //     } // check if firebase user exists
  //   });
  //   super.initState();
  // } //initState

  @override
  void dispose() {
    loginStateSubscription.cancel();
    super.dispose();
  }

  bool showSpinner = false;
  String email, password;
  @override
  Widget build(BuildContext context) {
    final authBloc = Provider.of<AuthBloc>(context);
    return Scaffold(
      backgroundColor: Color(0xFF264653),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                  //Do something with the user input.
                },
                decoration: kTextfieldDecoration.copyWith(
                  hintText: 'Enter your email',
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                  //Do something with the user input.
                },
                decoration: kTextfieldDecoration.copyWith(
                  hintText: 'Enter your password',
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                title: 'Log In',
                colour: Colors.lightBlueAccent,
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  }); //showSpinner becomes true
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                    if (user != null) {
                      Navigator.pushNamed(context, WelcomeScreen.id);
                    } // go to chat screen if user exists
                    setState(() {
                      showSpinner = false;
                    }); //showSpinner becomes false
                  } /*try for user credentials*/ catch (e) {
                    print(e);
                  } // catch firebase unauthorized access
                }, //onPressed
              ),
              SignInButton(
                Buttons.Google,
                elevation: 5.0,
                onPressed: () {
                  authBloc.loginGoogle();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
