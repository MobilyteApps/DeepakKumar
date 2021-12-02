

import 'package:flutter/material.dart';

import '../Authentications/google_auth.dart';

class logout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<logout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                    // signOut(context);
                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                       content: Text("You are successfully Sign-out"),
                     ));
                },
                child: Text(
                  "Logout from google account",
                ),
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  textStyle: const TextStyle(fontSize: 20),
                  padding: const EdgeInsets.all(10),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
