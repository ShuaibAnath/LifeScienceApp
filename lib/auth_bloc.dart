import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ls_app_firebase_login/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

class AuthBloc {
  String userGmail = '';
  String userRegGmail;
  String userGmailPlatformErrorCode = '';
  String userGmailPlatformError = '';
  String userGmailFbErrorCode = '';
  String userGmailFbError = '';
  String userRegGmailPlatformErrorCode = '';
  String userRegGmailPlatformError = '';
  String userRegGmailFbErrorCode = '';
  String userRegGmailFbError = '';

  final authService = AuthService();
  bool userExistsOnFirestore = false;
  final googleSignIn = GoogleSignIn(
      scopes: ['email']); //permissions your app require, there may be more
  Stream<User> get currentUser => authService.currentUser; // gets user

  Future<bool> doesEmailExist(String userEmail) async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: userEmail)
        .limit(1)
        .get();
    final List<DocumentSnapshot> documents = result.docs;
    return documents.length == 1;
  }

  loginGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      ); // pass these credentials to firebase
      print('These are the CREDENTIALS = $credential');
      //Firebase sign in
      final result = await authService
          .signInWithCredential(credential); //call out to service
      userGmail = result.user.email;
      userExistsOnFirestore = await doesEmailExist(userGmail);
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool('userExists', userExistsOnFirestore);
      userGmailPlatformErrorCode = '';
      userGmailPlatformError = '';
      userGmailFbErrorCode = '';
      userGmailFbError = '';

    } on PlatformException catch (e) {
      print('this is PlatformException: $e');
      print('Failed with error code: ${e.code}');
      print(e.message);
      userGmailPlatformErrorCode = e.code;
      userGmailPlatformError = e.message;
    } on FirebaseAuthException catch (e) {
      print('is firebase exception');
      print('Failed with error code: ${e.code}');
      print(e.message);
      userGmailFbErrorCode = e.code;
      userGmailFbError = e.message;
    }
  } // loginGoogle function

  registerWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      ); // pass these credentials to firebase
      print('These are the CREDENTIALS = $credential');
      //Firebase sign in
      final result = await authService
          .signInWithCredential(credential); //call out to service
      userRegGmail = result.user.email;
      userRegGmailPlatformErrorCode = '';
      userRegGmailPlatformError = '';
      userRegGmailFbErrorCode = '';
      userRegGmailFbError = '';

    } on PlatformException catch (e) {
      print('this is PlatformException: $e');
      print('Failed with error code: ${e.code}');
      print(e.message);
      userRegGmailPlatformErrorCode = e.code;
      userRegGmailPlatformError = e.message;
    } on FirebaseAuthException catch (e) {
      print('is firebase exception');
      print('Failed with error code: ${e.code}');
      print(e.message);
      userRegGmailFbErrorCode = e.code;
      userRegGmailFbError = e.message;
    }
  }

  logout() {
    authService.logout();
    print('Logout successful');
  } //logout function

} // AuthBloc class
