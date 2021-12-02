import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:singup_page/Gallary/play_video.dart';
import 'package:video_player/video_player.dart';

class Videoplaylist extends StatefulWidget {
  Videoplaylist({
    Key? key,
  }) : super(key: key);

  @override
  _Videoplaylist createState() {
    return _Videoplaylist();
  }
}

class _Videoplaylist extends State<Videoplaylist> {
  final firestoreInstance = FirebaseFirestore.instance;
  var size, height, width;

  // String image='';
  List<String> video_view = [];
  VideoPlayerController? _videoPlayerController;

  void initState() {
    super.initState();
    getFirebaseVideoFolder();
  }

  void getFirebaseVideoFolder() {
    // image_view.clear();
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('Videos');
    firebaseStorageRef.listAll().then((result) {
      result.items.forEach((ref) async {
        await firebaseStorageRef
            .child('${ref.fullPath.split('/')[1]}')
            .getDownloadURL()
            .then((value) {
          print('url>>>> $value');
          video_view.add(value);
          setState(() {});
        });
      });

      //print('Found file: ${result.items[0].fullPath.split('/')[1]}');
      print("result is $result");
    });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text("Video Gallery"),
        ),
        body: GridView.builder (
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, crossAxisSpacing: 4, mainAxisSpacing: 8),
            itemCount: video_view.length,
            itemBuilder: (BuildContext context, int index) {
              if (video_view[index].isEmpty) {
                return CircularProgressIndicator();
              } else
                return Container(
                  color: Colors.black,

                  child: IconButton(
                    icon: Icon(
                      Icons.play_arrow,

                      color: Colors.grey,
                      size: 30,
                    ),
                    onPressed: () {
                      Get.to(PlayVideo(
                        video_view: video_view[index],
                      ));
                    },
                  ),
                  //video_view[index],
                  // fit: BoxFit.cover );}
                );
            }));
  }
}
