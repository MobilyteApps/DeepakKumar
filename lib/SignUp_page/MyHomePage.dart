import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:singup_page/Api_hits_data/Api_data.dart';
import 'package:singup_page/List_of_friends/datafetch.dart';
import 'package:singup_page/file_picker/image_picker_screen.dart';
import 'package:singup_page/Authentications/facebook_auth.dart';
import 'package:singup_page/Authentications/google_auth.dart';

import 'package:singup_page/Api_hits_data/insomnia_data.dart';

import 'package:singup_page/SignIn_page/signUp_first_page.dart';

import '../Authentications/authentication.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title, User? user}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formkey = GlobalKey<FormState>();
  final firestoreInstance = FirebaseFirestore.instance;
  String name = 'qwerty';

  String first = '',
      last = '',
      email = '',
      password = '',
      occupation = '',
      company = '';
  int phone = 0;

  bool _passwordVisibel = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2F455C),

      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                // padding: EdgeInsets.only(top: 30),
                margin: EdgeInsets.only(right: 250, top: 20),

                child: Text(
                  'Sign Up',
                  // textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.green,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 100, top: 5),
                child: Text(
                  ' Create an account or login to begin',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 5),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name ';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    first = value!;
                  },
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'First Name',
                      focusedBorder: UnderlineInputBorder()),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name ';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    last = value!;
                  },
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(), labelText: 'Last Name'),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone ';
                    }
                    return null;
                  },
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Phone Number'),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email address ';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    email = value!;
                  },
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(), labelText: 'Email'),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password ';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    password = value!;
                  },
                  style: TextStyle(color: Colors.white),
                  obscureText: !_passwordVisibel,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisibel
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisibel = !_passwordVisibel;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your occupation ';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    occupation = value!;
                  },
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(), labelText: 'Occupation'),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your company name ';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    company = value!;
                  },
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Company Name'),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 230, top: 12),
                child: Text('Setup Signature',
                    style: TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 16,
                    )),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                padding: EdgeInsets.only(right: 60, left: 60),
                color: Colors.white10,
                child: TextButton(
                  child: Text(
                    'Upload Signature',
                    style: TextStyle(
                      color: Colors.greenAccent,
                    ),
                  ),
                  onPressed: () {},
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                padding: EdgeInsets.only(right: 70, left: 70),
                decoration: BoxDecoration(
                  borderRadius: new BorderRadius.circular(10),
                  gradient: LinearGradient(colors: [
                    Colors.blue,
                    Colors.greenAccent,
                  ]),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      _formkey.currentState!.save();

                      AuthenticationHelper()
                          .signup(email, password, first, last, occupation,
                              company, phone, context)
                          .then((result) {
                        if (result != null) {
                          Get.to(MysigUpPage(title: ''));
                          var firebaseUser = FirebaseAuth.instance.currentUser;
                          firestoreInstance
                              .collection("emp_detail")
                              .doc(firebaseUser!.uid)
                              .set({
                            "uid":firebaseUser.uid,
                            "first_name": first,
                            "last_name": last,
                            "phone": phone,
                            "email": email,
                            "occupation": occupation,
                            "company": company,
                          }).then((value) {

                          });
                      

                      
                      
                      
                        } else {
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text(
                              result,
                              style: TextStyle(fontSize: 16),
                            ),
                          ));
                        }
                      }
                              //ScaffoldMessenger.of(context).showSnackBar(
                              //const SnackBar(content: Text('Processing Data')),

                              );
                    }
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(15),
                child: TextButton(
                  child: Text(
                    'Login with email',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    textStyle: const TextStyle(fontSize: 20),
                    padding: const EdgeInsets.all(10),
                  ),
                  onPressed: () {
                    Get.to(MysigUpPage(title: ''));
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(15),
                child: ElevatedButton(
                  child: Text(
                    'Login with google',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    textStyle: const TextStyle(fontSize: 20),
                    padding: const EdgeInsets.all(10),
                  ),
                  onPressed: () {
                  signup(context);
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(15),
                child: ElevatedButton(
                  child: Text(
                    'Login with facebook',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    textStyle: const TextStyle(fontSize: 20),
                    padding: const EdgeInsets.all(10),
                  ),
                  onPressed: () {
                    signInWithFacebook(context);
                  },
                ),
              ),

              Container(
                margin: EdgeInsets.all(15),
                child: ElevatedButton(
                  child: Text(
                    'Fetch API data',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    textStyle: const TextStyle(fontSize: 20),
                    padding: const EdgeInsets.all(10),
                  ),
                  onPressed: () {
                    Get.to(Apidata());
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(15),
                child: ElevatedButton(
                  child: Text(
                    'Fetch insomnia data',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    textStyle: const TextStyle(fontSize: 20),
                    padding: const EdgeInsets.all(10),
                  ),
                  onPressed: () {
                    Get.to(Insomniadata());
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(15),
                child: ElevatedButton(
                  child: Text(
                    'Image Picker',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    textStyle: const TextStyle(fontSize: 20),
                    padding: const EdgeInsets.all(10),
                  ),
                  onPressed: () {
                    Get.to(FilePickerr());
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
