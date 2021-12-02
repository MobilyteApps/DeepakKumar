import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:singup_page/Chat_screen/chat.dart';
import 'package:singup_page/List_of_friends/datafetch.dart';
import 'package:singup_page/SignIn_page/signUp_first_page.dart';

import '../SignUp_page/MyHomePage.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _email;

  void getvalidationData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _email = prefs.getString('email');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: (_email == null ? MyHomePage(title: '') : NoteList(email: _email,)),
    );
  }

  @override
  void initState() {
    super.initState();
    getvalidationData();
  }
}
