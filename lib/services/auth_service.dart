import 'package:firebase_auth/firebase_auth.dart';
//backend for the google sign in
class AuthService {
  final _auth = FirebaseAuth.instance;

  //sign in with google function (using firebase)
  Future<UserCredential> signInWithCredential(AuthCredential credential) {
    return _auth.signInWithCredential(credential);
  }

//sign out with google function (using firebase)
  Future<void> logout() => _auth.signOut();

  //create stream to create and return a user, will know if user is logged in and logged out using this
  Stream<User> get currentUser => _auth.authStateChanges();
}
