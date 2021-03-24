import 'package:ls_app_firebase_login/compontents/rounded_button.dart';
import 'package:ls_app_firebase_login/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ls_app_firebase_login/screens/welcome_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  final String name;
  final String surname;
  final String schoolName;
  final String province;
  final String cellNum;

  const RegistrationScreen(
      {Key key,
      @required this.name,
      @required this.surname,
      @required this.schoolName,
      @required this.province,
      @required this.cellNum})
      : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String email = '';
  String password = '';
  bool showSpinner = false;

  final _auth = FirebaseAuth.instance;
  // create a listener for google sign in

  Future<void> _showMyDialogReg(String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Incomplete details'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF264653),
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
                print(widget.name);
                email = value;
                //Do something with the user input.
              },
              decoration: kTextfieldDecoration.copyWith(
                hintText: 'Enter your email',
                fillColor: Colors.white,
                filled: true,
              ),
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
                hintText: 'Enter a password, at least 6 characters',
                fillColor: Colors.white,
                filled: true,
              ),
            ), //password

            RoundedButton(
              title: 'Register',
              colour: Colors.blueAccent,
              onPressed: () async {
                if (email.isEmpty ||
                    (email == null) ||
                    password.isEmpty ||
                    (password == null)) {
                  _showMyDialogReg(
                      'Please enter both an e-mail and a password.');
                } else if (password.length < 6) {
                  _showMyDialogReg(
                      'Please enter a password of at least 6 characters.');
                } else {
                  setState(() {
                    showSpinner = true;
                  }); //showSpinner becomes true
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password); // returns a future
                    if (newUser != null) {
                      firestore.collection('users').add({
                        'email': email,
                        'name': widget.name,
                        'surname': widget.surname,
                        'schoolName': widget.schoolName,
                        'province': widget.province,
                        'cellNumber': widget.cellNum
                      });
                      Navigator.pushNamed(context, WelcomeScreen.id);
                    } // if
                    setState(() {
                      showSpinner = false;
                    }); // spinner stops
                  } catch (e) {
                    _showMyDialogReg(
                        'Unable to Register.Please try again later or check your internet connection.');
                    print(e);
                  } //try-catch
                } //else
              }, //onPressed
            ),
          ],
        ),
      ),
    );
  }
}
