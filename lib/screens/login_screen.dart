import 'package:flutter/material.dart';
import 'package:ls_app_firebase_login/compontents/rounded_button.dart';
import 'package:ls_app_firebase_login/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ls_app_firebase_login/screens/dummy_screen.dart';
import 'package:ls_app_firebase_login/screens/requiredInfo_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
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

  Future<void> _showMyDialogReg(
      {String message, String heading, TextButton textButton, String userEmail}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(heading),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Register'),
              onPressed: () {
                //TODO: need to determine which screen you want to go to(but I made it the welcome screen).
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RequiredInfoScreen(userGmail: userEmail),
                  ),
                  ModalRoute.withName(RequiredInfoScreen.id),
                ); //navigator push and remove
              }, //onPressed
            ),
          textButton
          ],
        );
      },
    );
  } //function to return dialog box

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
                      // TODO: If statement for email and password validation
                      Navigator.pushNamed(context, DummyScreen.id);
                    } // go to chat screen if user exists
                    setState(() {
                      showSpinner = false;
                    }); //showSpinner becomes false
                  } /*try for user credentials*/
                  catch (e) {
                    print(e);
                    setState(() {
                      showSpinner = false;
                    });
                    _showMyDialogReg(
                        message:
                            'The account you tried logging in with does not exist, please ensure the email you entered is registered',
                        heading: 'Account Does Not exist',
                      textButton: TextButton(
                        child: Text('OK'),
                        onPressed: () => Navigator.pop(context),
                      ),
                        );
                  } // catch firebase unauthorized access
                }, //onPressed
              ),
              SignInButton(Buttons.Google, elevation: 5.0, onPressed: () {
                authBloc.loginGoogle().then((data) {
                  if (authBloc.userExistsOnFirestore) {
                    Navigator.pushNamed(context, DummyScreen.id);
                  } else {
                    _showMyDialogReg(
                      message:
                          'The account you tried logging in with does not exist, please proceed register',
                      heading: 'Account Does Not exist',
                      userEmail: authBloc.userGmail,
                    );
                  }
                });
              }),
            ],
          ),
        ),
      ),
    );
  }
}
