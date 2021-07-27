import 'package:appentus_demo/main.dart';
import 'package:appentus_demo/screens/auth/registration.dart';
import 'package:flutter/material.dart';
import '/store/action.dart' as  action;
import 'loginScreen.dart';
class AuthScreen extends StatefulWidget {
  AuthScreen({Key? key, }) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

@override
void initState() { 
  
  super.initState();
  
}
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
   
      body: Center(
        
        child: Column(
        
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           ElevatedButton(onPressed: (){
Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>LoginScreen()),
  );
           }, child: Text("Login")),
              ElevatedButton(onPressed: (){
Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => RegistrationScreen()),
  );
           }, child: Text("Register"))
          ],
        ),
      ),
     
    );
  }
}
