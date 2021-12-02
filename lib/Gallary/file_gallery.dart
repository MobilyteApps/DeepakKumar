



import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_filereader/flutter_filereader.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:open_file/open_file.dart';

class FileView extends StatefulWidget{
  final String files;

  FileView({Key? key, required this.files})  : super(key: key);




  @override
 _FileView  createState() => _FileView();
  }
class _FileView extends State<FileView>  {

   int? currentPage = 0;
   var fillpath;

   Future<void> openFile() async{
     OpenFile.open(widget.files);
   }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text("Document"),
        actions: <Widget>[

          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},

          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          ElevatedButton(
              onPressed: (){
                openFile();
              },
              child: Text(
                "Click here to open"
              )
          )


        ],

      ),

    );
  }
}

