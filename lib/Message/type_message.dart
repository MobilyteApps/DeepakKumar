


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Message extends StatefulWidget{
  Message({
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
  _MessageState createState() => _MessageState();



  }

class _MessageState  extends State<Message>{
  final _formkey = GlobalKey<FormState>();
  final firestoreInstance = FirebaseFirestore.instance;
  var chat;
  var firebaseuser = FirebaseAuth.instance.currentUser;
  var conversation;




  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    return Scaffold(
      body:  Form(
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
              Container(
                width: 320,
                height: 60,
                margin: EdgeInsets.only(left: 8),
                child: TextField(
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
                  onChanged: (value) {
                    chat = value;
                  },
                ),
              ),
              Container(
                width: 40,
                height: 60,
                margin: EdgeInsets.only(left: 5),
                child: IconButton(
                  icon: Icon(Icons.send),
                  iconSize: 35,
                  onPressed: () {
                    print(widget.userid);

                    if (_formkey.currentState!.validate()) {
                      _formkey.currentState!.save();

                      var firebaseuser = FirebaseAuth.instance.currentUser;


                      if(firebaseuser!.uid.hashCode <= widget.userid.hashCode)
                      {
                        conversation=firebaseuser.uid+widget.userid;
                      }
                      else{
                        conversation=widget.userid+firebaseuser.uid;
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

                  },
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    ),





    );

  }

}

