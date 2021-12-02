
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:singup_page/List_of_friends/datafetch.dart';
import '../Authentications/authentication.dart';

class MysigUpPage extends StatefulWidget {
  MysigUpPage({Key? key, required this.title}) : super(key: key);
  final String title;


  @override
  _MysignUpPageState createState() => _MysignUpPageState();
}

class _MysignUpPageState extends State<MysigUpPage> {


  final _formkey= GlobalKey<FormState>();
  String email='',pass='',first='';
    var id;
  bool _passwordvisibility =false;

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("SignIn Page"),
      ),
      body:
      SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(

            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[

              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  'COMEZY',
                  style: new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 30, color: Colors.blue),
                ),

              ),
              Container(
                height: 100,
                width: 100,
                child: Image.asset('assets/image/hh.png',),
              ),


              Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.only(right: 20,left: 20),
              ),
              Text(
                'Create a account or login to begin',
                style: new TextStyle(
                    fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
              ),

              Container(
                padding: EdgeInsets.only(right: 20,left: 20),
                child: Column(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all( 10),),
                  TextFormField(
                    validator: (value){
                      if(value==null||value.isEmpty)
                        {
                          return 'Please enter the valid user name';
                        }
                      return null;
                    },
                    onSaved: (value)
                    {
                      email=value!;
                    },
                    decoration: InputDecoration(
                      icon: Icon(Icons.mail),
                      border: UnderlineInputBorder(),
                      labelText: 'Enter your email address',
                    ),
                  ),

                  TextFormField(
                    obscureText: !_passwordvisibility,
                    validator: (value){
                      if(value==null||value.isEmpty)
                      {
                        return 'Please enter the valid password';
                      }
                      return null;
                    },
                    onSaved: (value)
                    {
                      pass=value!;
                    },
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      border: UnderlineInputBorder(),
                      labelText: 'Enter your password',
                      suffixIcon: IconButton(
                        icon: Icon(
                        _passwordvisibility
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                        onPressed: () {
                        setState(() {
                          _passwordvisibility = !_passwordvisibility;
                        });
                      },

                      )
                    ),

                  ),

                  Container(
                    margin: EdgeInsets.all(15),

                    child: ElevatedButton(
                      child: Text('SignIn with email', style: TextStyle(fontSize: 20.0),),
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        textStyle: const TextStyle(fontSize: 20),
                        padding: const EdgeInsets.all(10),
                      ),
                      onPressed: () {
                       if(_formkey.currentState!.validate())
                         {
                           _formkey.currentState!.save();
                           AuthenticationHelper()
                               .signIn(email, pass, context)
                               .then((result) async {
                             if (result!= null) {print("success");
                             final SharedPreferences prefs = await SharedPreferences.getInstance();
                             prefs.setString('email', email);
                         //   Get.to(Home(title: '',));
                               Get.to(NoteList(email: email,));


                             } else {
                               Scaffold.of(context).showSnackBar(SnackBar(
                                 content: Text(
                                   "unmatch",
                                   style: TextStyle(fontSize: 16),
                                 ),
                               ));
                             }
                           });

                         }



                      },
                    ),
                  ),

                  Text(
                    'Forget Password?',
                    style: new TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,

                    ),
                  ),

                ]),
              ),
            ],
          ),
        ),

      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
