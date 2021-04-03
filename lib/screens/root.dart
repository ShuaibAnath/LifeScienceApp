import 'package:flutter/material.dart';
import 'package:ls_app_firebase_login/screens/dummy_screen.dart';
import 'package:ls_app_firebase_login/screens/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'package:ls_app_firebase_login/auth_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthStatus{
  loggedIn,
  notLoggedIn,
}

class RootScreen extends StatefulWidget {
  static const id = 'root_screen';
  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  AuthStatus _authStatus = AuthStatus.notLoggedIn;
  Widget retValue;
  bool isUserRegisteredOnFirestore = false;
  bool checkDone = false;
  @override
  void initState() {

    var authBloc = Provider.of<AuthBloc>(context, listen: false);
    authBloc.currentUser.listen((fbUser) {
      if (fbUser != null) {
        setState(() {
          _authStatus = AuthStatus.loggedIn;
        });
      } // check if firebase user exists
    });

    isUserRegistered().then((data){
      isUserRegisteredOnFirestore = data;
      print('The data is = $isUserRegisteredOnFirestore');
      if(_authStatus == AuthStatus.loggedIn && isUserRegisteredOnFirestore == true){
        retValue = DummyScreen();
      }
      else{
        retValue = WelcomeScreen();
      }
      setState(() {
        checkDone = true;
      });
    });

    super.initState();
  }//init state to autoLogin


  Future<bool> isUserRegistered() async {
  final prefs = await SharedPreferences.getInstance();
   final userRegistered = prefs.getBool('userExists')?? false;
   return userRegistered;
  }//is user registered

  @override
  Widget build(BuildContext context) {
     return checkDone ? retValue : Scaffold(body: SafeArea(child: CircularProgressIndicator()));
  }
}
