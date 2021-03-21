import 'package:flutter/material.dart';
import 'package:ls_app_firebase_login/screens/welcome_screen.dart';
import 'package:ls_app_firebase_login/screens/login_screen.dart';
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
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RequiredInfoScreen.id: (context) => RequiredInfoScreen(),
      },
    );
  }
}