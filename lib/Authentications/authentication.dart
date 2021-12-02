

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  get user => _auth.currentUser;
//SIGN UP
  Future<dynamic> signup(String email, String password,String first,String comapany, String occupation, String last, int phone,BuildContext context, ) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ).whenComplete(()  {
        print("result");
      });
      return null;
    } on FirebaseAuthException catch (e) {
      print(e);
      Fluttertoast.showToast(
        msg: 'UnScuccesful',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      return e.message;
    }
  }
  //SIGN IN
  Future<User?> signIn(String email, String password, BuildContext context) async {
    try {
      UserCredential result =
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      final User? user = result.user;
      return user;
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
        msg: 'Successful',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }
  //SIGN OUT METHOD
  Future<void> signOut() async {
    await _auth.signOut();
    print('signout');
  }

}