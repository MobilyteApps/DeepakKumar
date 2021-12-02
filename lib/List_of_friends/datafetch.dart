import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:singup_page/SignUp_page/MyHomePage.dart';
import 'package:singup_page/Chat_screen/chat.dart';
import 'package:singup_page/Authentications/facebook_auth.dart';

import '../Authentications/google_auth.dart';


class NoteList extends StatefulWidget {
  NoteList({Key ,key ,required this.email}): super(key: key);
  final  email;

  @override
  _NoteList createState() {
    // TODO: implement createState
    return _NoteList();
  }
}

class _NoteList extends State<NoteList> {

  final db = FirebaseFirestore.instance;
//  String documentID=  get_data();

  @override
  Widget build(BuildContext context) {


    // TODO: implement build

    return Scaffold(
      drawer: Drawer(
        child: Container(
          width: 5,
          height: 5,
          child: ElevatedButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove('email');

              signOut(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("You are successfully logout"),

              ));
              signOutWithFacebook(context);
              Get.to(MyHomePage(title: ''));
            },
            child: Text("Logout"),
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(widget.email),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot?>(
        stream: db.collection('emp_detail').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                Map<int, dynamic> data = snapshot.data!.docs.asMap();
                Map? getDocs = data[index].data() ;
                if(getDocs!['email'] != widget.email) {

                  return
                    Container(
                      height: 80,
                      

                      child: Card(
                        elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),

                          ),

                          child: Row(

                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [

                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                    height: 45,
                                    width: 45,

                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.deepPurpleAccent,
                                    ),
                                    child: Center(
                                        child: Text(
                                          "${getDocs['first_name'][0]}"
                                              .toUpperCase(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                           // fontWeight: FontWeight.bold,
                                          ),
                                        ))),
                              ),

                              Container(
                                margin: EdgeInsets.only(top: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Text(
                                      "${getDocs['first_name']}".capitalize! +
                                          "  " "${getDocs['last_name']}".capitalize!,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(

                                      "${getDocs['email']}",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    margin: EdgeInsets.only(left: 130,),
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: IconButton(
                                        icon: Icon(Icons.message,color: Colors.grey,),
                                        onPressed: () {
                                          Get.to(Chat(
                                              title: '${getDocs['first_name']}'.capitalize! +
                                                  " " '${getDocs['last_name']}'.capitalize!,
                                              dp: "${getDocs['first_name'][0]}"
                                                  .toUpperCase(),
                                              userid: '${getDocs["uid"]}')
                                          );

                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )),
                    );
                }
                else{
                  Container();
                }
             return Container(); },


            );

        },
      ),

    );
  }
}
