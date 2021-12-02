import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:singup_page/List_of_friends/datafetch.dart';
import 'package:singup_page/Authentications/fpage.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
Future<void> signInWithFacebook(BuildContext context) async {

  // Trigger the sign-in flow
  final LoginResult loginResult = await FacebookAuth.instance.login();
  if(LoginResult != null)
    {
      var accessToken;
      final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Once signed in, return the UserCredential
    UserCredential result= await auth.signInWithCredential(facebookAuthCredential);
    User? user = result.user;

    print(result);
    if(result != null)
      {
        Get.to(NoteList(email:''));
      }
    }
}
Future<void> signOutWithFacebook(BuildContext context) async {
   await auth.signOut();



}