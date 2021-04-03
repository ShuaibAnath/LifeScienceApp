import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ls_app_firebase_login/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AuthBloc {
  String userGmail = '';
  String userRegGmail;

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
      final result = await authService.signInWithCredential(credential); //call out to service
      userGmail = result.user.email;
      userExistsOnFirestore =  await doesEmailExist(userGmail);
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool('userExists', userExistsOnFirestore);


    } catch (error) {
      print(error);
    } //catch
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
      final result = await authService.signInWithCredential(credential); //call out to service
      userRegGmail = result.user.email;
    } catch (error) {
      print(error);
    } //catch
  }

  logout() {
    authService.logout();
    print('Logout successful');
  } //logout function

} // AuthBloc class
