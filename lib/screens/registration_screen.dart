import 'package:ls_app_firebase_login/compontents/rounded_button.dart';
import 'package:ls_app_firebase_login/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ls_app_firebase_login/screens/welcome_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String name, surname, schoolName, province, cellNum;
  String email, password;
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: Hero(
                tag: 'logo',
                child: Container(
                  height: 140.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
            ),

            TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                email = value;
                //Do something with the user input.
              },
              decoration:
                  kTextfieldDecoration.copyWith(hintText: 'Enter your email'),
            ), //email
            SizedBox(
              height: 5.0,
            ),
            TextField(
              obscureText: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
                password = value; //Do something with the user input.
              },
              decoration: kTextfieldDecoration.copyWith(
                  hintText: 'Enter your password'),
            ), //password
            RoundedButton(
              title: 'Register',
              colour: Colors.blueAccent,
              onPressed: () async {
                setState(() {
                  showSpinner = true;
                }); //showSpinner becomes true
                try {
                  final newUser = await _auth.createUserWithEmailAndPassword(
                      email: email, password: password); // returns a future
                  if (newUser != null) {
                    Navigator.pushNamed(context, WelcomeScreen.id);
                  } // if
                  setState(() {
                    showSpinner = false;
                  }); // spinner stops
                } catch (e) {
                  print(e);
                } //try-catch
              }, //onPressed
            ),
          ],
        ),
      ),
    );
  }
}
