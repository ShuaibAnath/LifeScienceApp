
import 'package:flutter/material.dart';
import 'package:ls_app_firebase_login/auth_bloc.dart';
import 'package:ls_app_firebase_login/screens/dummy_screen.dart';
import 'package:ls_app_firebase_login/screens/root.dart';
import 'package:ls_app_firebase_login/screens/welcome_screen.dart';
import 'package:ls_app_firebase_login/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen.dart';
import 'screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/requiredInfo_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(LsApp());
}

class LsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Provider(
      create: (context) => AuthBloc(),
      child: MaterialApp(
        initialRoute:  RootScreen.id,
        routes: {
          RootScreen.id: (context) => RootScreen(),
          WelcomeScreen.id: (context) => WelcomeScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          RequiredInfoScreen.id: (context) => RequiredInfoScreen(userGmail:''),
          DummyScreen.id:(context) => DummyScreen(),
        },
      ),
    );
  }
}

