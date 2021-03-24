import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ls_app_firebase_login/services/auth_service.dart';

class AuthBloc {
  String userGmail = '';
  final authService = AuthService();
  final googleSignIn = GoogleSignIn(
      scopes: ['email']); //permissions your app require, there may be more

  Stream<User> get currentUser => authService.currentUser; // gets user

  loginGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      ); // pass these credentials to firebase

      //Firebase sign in
      final result = await authService
          .signInWithCredential(credential); //call out to service
      print('${result.user.displayName}');
      userGmail = result.user.email;
    } catch (error) {
      print(error);
    } //catch
  } // loginGoogle function

  logout() {
    authService.logout();
    print('Logout successful');
  } //logout function

} // AuthBloc class
