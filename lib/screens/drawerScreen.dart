import 'dart:convert';

import 'package:appentus_demo/main.dart';
import 'package:appentus_demo/screens/auth/authScreen.dart';
import 'package:flutter/material.dart';
import '/store/action.dart' as action;
class DrawerScreen extends StatefulWidget {
  DrawerScreen({Key? key}) : super(key: key);

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
   _logOut(){
     Navigator.pushReplacement(  context,
    MaterialPageRoute(builder: (context) => AuthScreen()),);
     store.dispatch(action.loginData(context, null));
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(height: 50,child: TextButton(onPressed: (){
        _logOut();
      }, child: Text("Log Out")),),
      body: Container(
        child: Center(
          child: Column(
            crossAxisAlignment:CrossAxisAlignment.center,
           
            children: [
              SizedBox(height: 40,),
             _avatar(),
             SizedBox(height: 10,),
              Text(store.state.loginData.name!),
               SizedBox(height: 10,),
              Text(store.state.loginData.email!),
               SizedBox(height: 10,),
              Text(store.state.loginData.mobileNo!.toString()),

            ],
          ),
        ),
      ),
    );
  }

Widget _avatar(){
    final bytes = base64Decode(store.state.loggedInUserData.avatar!);
  return Container(
    width: 100,
    height: 100,
    child: CircleAvatar(
      
      backgroundImage: MemoryImage(bytes),),
  );
}
}