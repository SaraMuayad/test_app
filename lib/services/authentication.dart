import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';

import '../models/user.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  dynamic _userFormFirebase(User? user) {
    return user != null ? Users(userid: user.uid) : null;
  }

  Stream<Users> get userStream {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFormFirebase(user));

    //_userFormFirebase
  }

  // login as demo
  Future SignInAnony() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return Users(userid: user!.uid);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return null;
    }
  }

// registertion with email and password
  Future Register(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return Users(userid: user!.uid);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future SingnInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return Users(userid: user!.uid);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return null;
    }
  }
// Singn with google account

  Future SinginWithGoogle() async {
    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
      UserCredential result = await _auth.signInWithCredential(credential);
      print(result.user?.displayName);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return null;
    }
  }

// logout
  Future SignOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return null;
    }
  }
}
