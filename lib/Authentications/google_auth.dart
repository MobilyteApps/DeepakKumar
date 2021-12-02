import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:singup_page/List_of_friends/datafetch.dart';
import 'package:singup_page/Logout_from_app/logout.dart';
import 'package:singup_page/SignIn_page/signUp_first_page.dart';

final FirebaseAuth auth = FirebaseAuth.instance;


Future<void> signup(BuildContext context) async {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  if (googleSignInAccount != null) {
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;
    final AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    // Getting users credential
    UserCredential result = await auth.signInWithCredential(authCredential);
    User? user = result.user;

    if (result != null) {
   Get.to(NoteList(email: '',));
   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
     content: Text("You are successfully sign-In"),
   ));

    }


    // for go to the HomePage screen
  }
}
Future<void> signOut(BuildContext context) async {
  await auth.signOut();
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signOut();
}
