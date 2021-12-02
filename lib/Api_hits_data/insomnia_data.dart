




import 'package:flutter/material.dart';
import 'package:singup_page/Models/insomnia_model.dart';

class Insomniadata extends StatefulWidget{
  
  
  
  
  @override
  _Insomniadata createState() => _Insomniadata();

  
}

class _Insomniadata extends State<Insomniadata> {



  void initState()
  {
    super.initState();
     fetchUserData();
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Scaffold(
     appBar: AppBar(),
     body: FutureBuilder<List<Datum>>(
       future: fetchUserData(),
       builder: (context, snapshot) {
         if(snapshot.hasData){
           List<Datum>? data= snapshot.data;
           return ListView.builder(
               itemCount: data!.length,
               itemBuilder: (BuildContext context, int index){
                 return Column(
                   children: [
                     Text(data[index].id.toString())
                   ],
                 );
           });

   }
         else if(snapshot.hasError)
           {
             return Text('${snapshot.hasError}');
           }
         return
             Center(child: CircularProgressIndicator());
   }


     ),
   );
  }
}