import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:singup_page/Message/buildItem.dart';

import 'package:path/path.dart';

import '../file_picker/image_picker_screen.dart';

class Chat extends StatefulWidget {
  Chat({
    Key? key,
    required this.title,
    required this.userid,
    required this.dp,
  }) : super(key: key);
  final String title;
  final String dp;
  var userid;
  var listMessage;

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final _formkey = GlobalKey<FormState>();
  final firestoreInstance = FirebaseFirestore.instance;
  var chat;
  var firebaseuser = FirebaseAuth.instance.currentUser;
  var conversation;
  var listMessage;
  var textEditingController= TextEditingController();
  File? _imagefile;
  final picker = ImagePicker();
  String url="";

  @override
  void initState() {
    super.initState();
    if (firebaseuser!.uid.hashCode <= widget.userid.hashCode) {
      conversation = firebaseuser!.uid + widget.userid;
    } else {
      conversation = widget.userid + firebaseuser!.uid;
    }
  }
  Future pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _imagefile = File(pickedFile!.path);
    });
  }

  Future uploadImageToFirebase(BuildContext context) async {
    String fileName = basename(_imagefile!.path);
    Reference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('uploads/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(_imagefile!);
    TaskSnapshot snapshot = await uploadTask;
    uploadTask.then((res) {
      res.ref.getDownloadURL();
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.deepPurpleAccent,
                ),
                child: Center(
                    child: Text(
                  widget.dp,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ))),
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
            SizedBox(
              width: 5,
            ),
          //  Text(widget.title),
          ],
        ),
        actions: [],
      ),
      body:
         Column(
          children: [


               Expanded(

                 child: StreamBuilder(
                  stream: firestoreInstance
                      .collection('chat')
                      .doc(conversation)
                      .collection('msg')
                      .orderBy('Time', descending: true)
                      // .limit(20)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      listMessage = snapshot.data!.docs;
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(10.0),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          Map<int, dynamic> data = snapshot.data!.docs.asMap();
                          Map? getDocs = data[index].data();
                          return buildItem( index,  firebaseuser!.uid, getDocs);

                        },

                       reverse: true,
                        //   controller: listScrollController,
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
              ),
               ),

            SizedBox(
              height: 60,
              child: Form(
                key: _formkey,
                child: Container(
                  constraints: BoxConstraints.expand(),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage("assets/image/whats.png"),
                    fit: BoxFit.cover,
                  )),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      
                      children: [



                          Row(
                            children: [

                              IconButton(
                                  onPressed: () async {
                                  pickImage();


                                  },

                                  icon: Icon(Icons.camera),
                              iconSize: 35,),
                              Container(
                                width: 280,
                                // height: 60,
                                margin: EdgeInsets.only(left: 8),
                                child: TextFormField(

                                  validator: (value)
                                  {
                                    if(value==null || value.isEmpty)
                                      {
                                        return 'Please enter your message';
                                      }
                                    return null;
                                  },

                                  controller: textEditingController,
                                  // : (value) {
                                  //   if (value == null || value.isEmpty) {
                                  //     return 'Please enter your company name ';
                                  //   }
                                  //   return null;
                                  // },
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    hintText: "Enter your message here...",
                                  ),
                                  onSaved: (value) {
                                    chat = value;
                                  },
                                ),
                              ),
                            ],
                          ),

                        Container(
                          width: 40,
                          // height: 60,
                          margin: EdgeInsets.only(left: 5),
                          child: IconButton(
                            icon: Icon(Icons.send),
                            iconSize: 35,
                            onPressed: () {
                              print(widget.userid);

                              if (_formkey.currentState!.validate()) {
                                _formkey.currentState!.save();

                                var firebaseuser =
                                    FirebaseAuth.instance.currentUser;

                                if (firebaseuser!.uid.hashCode <=
                                    widget.userid.hashCode) {
                                  conversation = firebaseuser.uid + widget.userid;
                                } else {
                                  conversation = widget.userid + firebaseuser.uid;
                                }
                                print(firebaseuser.uid.hashCode);
                                print(widget.userid.hashCode);

                                firestoreInstance
                                    .collection("chat")
                                    .doc(conversation)
                                    .set({
                                  "createdId": DateTime.now(),
                                  "member": [firebaseuser.uid, widget.userid],
                                  "title": (widget.title),
                                }).then((value) {
                                  var firebaseuser =
                                      FirebaseAuth.instance.currentUser;

                                  firestoreInstance
                                      .collection("chat")
                                      .doc(conversation)
                                      .collection("msg")
                                      .doc()
                                      .set({
                                    "Time": DateTime.now(),
                                    "senderId": (firebaseuser!.uid),
                                    "recieverId": widget.userid,
                                    "message": chat,
                                  }).then((value) {
                                    var firebaseuser =
                                        FirebaseAuth.instance.currentUser;
                                    firestoreInstance
                                        .collection("emp_detail")
                                        .doc(widget.userid)
                                        .collection("chat")
                                        .add({
                                      "createdAt": DateTime.now(),
                                      "senderId": firebaseuser!.uid,
                                      "message": chat,
                                    });
                                  });
                                });
                              }
                             textEditingController.clear();
                              uploadImageToFirebase(context);


                            },
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),


      //buildMessages(widget.userid,conversation),
    );
  }
}
