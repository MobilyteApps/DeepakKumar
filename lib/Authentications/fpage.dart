import 'package:flutter/material.dart';

class Fpage extends StatefulWidget{
  @override
  _MyAppState createState() {
    // TODO: implement createState
    return _MyAppState();
  }

}

class _MyAppState extends State<Fpage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(),

      body: Column(

        children: [
          Container(
           child: Text('This is facebook of the application',
           style: TextStyle(
             color: Colors.white,
             fontSize: 20,


      )
           ),

          )

        ]
      ),


    );
  }
}