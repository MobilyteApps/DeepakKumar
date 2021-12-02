

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:singup_page/Gallary/file_gallery.dart';
import 'package:singup_page/Gallary/image_gallery.dart';
import 'package:singup_page/Gallary/video_gallery.dart';
import 'package:video_player/video_player.dart';
import 'package:open_file/open_file.dart';



class FilePickerr extends StatefulWidget
{
  @override
    _FilePickerrState  createState() => _FilePickerrState();
  }

class _FilePickerrState extends State<FilePickerr> {
  VideoPlayerController? _videoPlayerController;
  File? _image;
  final picker = ImagePicker();
  String url = "";
  File? _video;
  String filetype = 'All';
  var fileList = ['All', 'Image', 'Audio', 'Multimedia'];

  FilePickerResult? result;
  PlatformFile? file;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      appBar: AppBar(),

      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Text("Select Image"),
              _image != null
                  ?
              Image.file(_image!,
                height: 150,
                width: 100,)
                  :
              Container(
                height: 150,
              ),

              _image == null
                  ? ElevatedButton(

                  onPressed: pickImage,

                  child: Text(
                      "Choose Image "
                  )
              )
                  : Container(),
              _image != null
                  ? ElevatedButton(

                  onPressed: () {
                    uploadImageToFirebase(context);

                    setState(() {
                      _image = null;
                    });
                  },

                  child: Text(
                      "Upload Image"
                  ))
                  : Container(),

              ElevatedButton(
                  onPressed: () {
                    Get.to(ImagePreview());
                  },

                  child: Text(
                      "Album"
                  )

              ),

              Text("Select Video"),
              if(_video != null)
                _videoPlayerController!.value.isInitialized
                    ? AspectRatio(
                  aspectRatio: _videoPlayerController!.value.aspectRatio,
                  child: Container(
                      height: 200,
                      width: 300,
                      child: VideoPlayer(_videoPlayerController!)),
                )
                    : Container(
                  height: 200,
                )
              else
                Container(),


              _video == null
                  ? ElevatedButton(

                  onPressed: pickVideo,

                  child: Text(
                      "Choose Video "
                  )
              )
                  : Container(),
              _video != null
                  ? ElevatedButton(

                  onPressed: () {
                    uploadVideoToFirebase(context);

                    setState(() {
                      _video = null;
                    });
                  },

                  child: Text(
                      "Upload video"
                  ))
                  : Container(),

              ElevatedButton(
                  onPressed: () {
                    Get.to(Videoplaylist());
                  },

                  child: Text(
                      "Album"
                  )

              ),

              Text(
                "Select File",

              ),

              ElevatedButton(
                  onPressed: () {
                   pickfiles();
                  },

                  child: Text(
                      "Choose file"
                  )),
              if (file != null) fileDetail(file!),
              if (file != null) ElevatedButton(onPressed: (){
                Get.to(FileView(files: file!.path.toString(), ));
                },


                child: Text('View Selected File'),)


            ],
          ),
        ),
      ),


    );
  }

  Future pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile!.path);
    });
  }

  Future pickVideo() async {
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    _video = File(pickedFile!.path);
    _videoPlayerController = VideoPlayerController.file(_video!)
      ..initialize().then((_) {
        setState(() {});
        _videoPlayerController!.play();
      });
  }

  Future uploadImageToFirebase(BuildContext context) async {
    String fileName = basename(_image!.path);
    Reference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('uploads/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(_image!);
    TaskSnapshot snapshot = await uploadTask;
    uploadTask.then((res) {
      res.ref.getDownloadURL();
    });
  }

  Future uploadVideoToFirebase(BuildContext context) async {
    String fileName = basename(_video!.path);
    Reference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('Videos/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(_video!);
    TaskSnapshot snapshot = await uploadTask;
    uploadTask.then((res) {
      res.ref.getDownloadURL();
    });
  }

  Future pickfiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    file = result.files.first;
    setState(() {});
  }

  Widget fileDetail(PlatformFile file)
  {
    final kb= file.size/1024;
    final mb=kb/1024;
    final size= (mb>=1) ? '${mb.toStringAsFixed(2)} MB' : '${kb.toStringAsFixed(2)} KB';
    return Padding(padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "File name =  ${file.name}",
          ),
          Text(
            "File size =  $size",
          ),
          Text(
            "File extension =  ${file.extension}",
          ),
          Text(
            "File Path =  ${file.path}",
          ),
        ],
      ),

    );



  }

  // void loadSelectedfiles(List<PlatformFile> files)
  // {
  //   //Get.to(FileList(files: files, onOpenedFile: viewfile));
  // }
  //
  // void viewfile(PlatformFile file)
  // {
  //   OpenFile.open(file.path);
  // }
}