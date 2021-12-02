

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
    return Row(
      children: <Widget>[
        // Text
        Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            child: Bubble(
                color: Colors.blueGrey,
                elevation: 0,
                padding: const BubbleEdges.all(10.0),
                nip: BubbleNip.rightTop,
                child: Text("${getdoc['message']}", style: TextStyle(color: Colors.black))),
            width: 200)
      ],
      mainAxisAlignment: MainAxisAlignment.end,
    );
  } else {
    // Left (peer message)
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        children: <Widget>[
          Row(children: <Widget>[
            Container(
              child: Bubble(
                  color: Colors.purple,
                  elevation: 0,
                  padding: const BubbleEdges.all(10.0),
                  nip: BubbleNip.leftTop,
                  child: Text("${getdoc['message']}", style: TextStyle(color: Colors.black))),
              width: 200.0,
              margin: const EdgeInsets.only(left: 10.0),
            )
          ])
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}