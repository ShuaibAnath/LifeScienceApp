import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:ls_app_firebase_login/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:provider/provider.dart';

class DummyScreen extends StatefulWidget {
  @override
  _DummyScreenState createState() => _DummyScreenState();
}

class _DummyScreenState extends State<DummyScreen> {
  @override
  Widget build(BuildContext context) {
    final authBloc = Provider.of<AuthBloc>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: SignInButton(Buttons.Google,
              elevation: 5.0, text: 'Sign out with Google', onPressed: () {
            authBloc.logout();

            Navigator.pop(context);
          }),
        ),
      ],
    );
  }
}
