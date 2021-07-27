import 'dart:convert';

import 'package:appentus_demo/helper/alertError.dart';
import 'package:appentus_demo/helper/validator.dart';
import 'package:appentus_demo/main.dart';
import 'package:appentus_demo/screens/auth/registration.dart';
import 'package:appentus_demo/screens/homePage.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '/store/action.dart' as action;

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _login() async {
    var box = Hive.box('usersList');

   
    if (box.isEmpty) {
      showErrorDialog(context, "Email doesn't exists.");
    } else {
       var _loginResponse = box.values.toList();
      Map? loginData;
      if (_loginResponse.isNotEmpty) {
        _loginResponse.forEach((e) {
          Map data = jsonDecode(e);
          if (data.containsKey(_emailController.text.trim())) {
            loginData = data;
          }
        });
        if (loginData == null) {
          showErrorDialog(context, "Email doesn't exists.");
        } else {
          if (_passwordController.text.trim() ==
              loginData!.values.first['password']) {
            store.dispatch(action.loginData(context, loginData!.values.first));
          } else {
            showErrorDialog(context, "Incorrect password!");
          }
        }
      }
       print(_loginResponse);
    }
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                        ),
                        validator: (value) => validateEmail(value!)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextFormField(
                        obscureText: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "* Password can't be empty";
                          }
                        }),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      height: 50,
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ElevatedButton(
                        style: ButtonStyle(),
                        child: Text('Login'),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _login();
                          }
                        },
                      )),
                  Container(
                      child: Row(
                    children: <Widget>[
                      Text('Does not have account?'),
                      TextButton(
                        child: Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegistrationScreen()),
                          );
                        },
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ))
                ],
              ),
            )));
  }
}
