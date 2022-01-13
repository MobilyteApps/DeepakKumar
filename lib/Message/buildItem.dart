

import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget buildItem(int index, var uid, var getdoc) {

  final firestoreInstance = FirebaseFirestore.instance;

  // if (!document['read'] && document['idTo'] == uid) {
  //   Database.updateMessageRead(document, coversation);
  // }

  if (getdoc['senderId'] == uid) {
    // Right (my message)
    return Column(
      children: <Widget>[
        // Text
        Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            child: Bubble(
                color: Colors.blueGrey,
                elevation: 0,
                padding: const BubbleEdges.all(10.0),
                nip: BubbleNip.rightTop,
                alignment: Alignment.topRight,
                child: Text("${getdoc['message']}", style: TextStyle(color: Colors.black))),
           ),
      ],
    crossAxisAlignment: CrossAxisAlignment.end,
    );
  } else {
    // Left (peer message)
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(children: <Widget>[

            Container(
              child: Bubble(
                  color: Colors.purple,
                  elevation: 0,
                  padding: const BubbleEdges.all(10.0),
                  nip: BubbleNip.leftTop,
                  alignment: Alignment.topLeft,
                  child: Text("${getdoc['message']}", style: TextStyle(color: Colors.black))),
              width: 200.0,
              margin: const EdgeInsets.only(left: 10.0),
            )
          ])
        ],


      ),
    );
  }
}