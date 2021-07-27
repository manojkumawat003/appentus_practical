import 'dart:convert';
import 'dart:io';
import 'dart:io' as Io;
import 'dart:math';
import 'package:appentus_demo/helper/alertError.dart';
import 'package:appentus_demo/helper/validator.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';


class RegistrationScreen extends StatefulWidget {
 
  RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
   TextEditingController _confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
 final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
    File? _image;
    bool _showImage = false;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        if(mounted){
          setState(() {
            _image = File(pickedFile.path);
            _showImage =true;
          });
        }
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void initState() { 
    super.initState();
  }

  storeInformationToLocal() async {
    
  var box =  Hive.box('usersList');


   if(_image == null){
  showErrorDialog(context,"Please, select pic");
   }else{
       final bytes = _image!.readAsBytesSync();
  Map body = {
     "id":"${Random().nextInt(100)}",
     "Name":"${_nameController.text.trim()}",
     "email":"${_emailController.text.trim()}",
     "password":"${_passwordController.text.trim()}",
     "mobileNo":"${_mobileController.text.trim()}",
     "avatar":base64Encode(bytes)
   };
  await box.add( jsonEncode({_emailController.text.trim():body}));

 final snackBar = SnackBar(
            content: Text('Successfully saved.'),
            action: SnackBarAction(
              label: 'ok',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );

          // Find the ScaffoldMessenger in the widget tree
          // and use it to show a SnackBar.
         _scaffoldkey.currentState!.showSnackBar(snackBar);
    Future.delayed(Duration(seconds: 1),(){
       if(mounted){
          Navigator.pop(context);
       }
    });}
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
            Navigator.pop(context);
        }),
        title: Text('Registration'),
      ),
      bottomNavigationBar: Container(
          height: 50,
          child: TextButton(
            child: Text("Submit"),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ////save to local
                storeInformationToLocal();
              }
            },
          )),
      body: SingleChildScrollView(
        child: Container(
          width: deviceWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _addPhotoWidget(deviceHeight, deviceWidth),
              _formFields(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _addPhotoWidget(deviceHeight, deviceWidth) {
    return Container(
      height: deviceHeight / 3,
      width: deviceWidth,
      color: Colors.grey[300],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(height: 100, width: 100, child: CircleAvatar(
            backgroundImage:
             _showImage  ?
             FileImage(_image!)
             :
            NetworkImage("https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png")as ImageProvider,
          )),
          SizedBox(
            height: 10,
          ),
          TextButton(onPressed: () {
            getImage();
          }, child: Text("Add Photo"))
        ],
      ),
    );
  }

  Widget _formFields() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextFormField(
                controller: _nameController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  labelText: "Name"),
                validator: (value) => validateName(value!)
                
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextFormField(
                controller: _emailController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(  border: OutlineInputBorder(),labelText: "Email"),
                 validator: (value) => validateEmail(value!)
              ),
            ),
          
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextFormField(
                controller: _mobileController,
                keyboardType: TextInputType.number,
                maxLength: 10,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(  border: OutlineInputBorder(),labelText: "Phone Number"),
                validator: (value) {
                    if (value!.trim().isEmpty) {
                    return "* required";
                  }
                  if(value.trim().length != 10){
return "* please enter correct mobile number";
                  }
                }
              ),
            ),
              Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextFormField(
                controller: _passwordController,
              obscureText: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(  border: OutlineInputBorder(),labelText: "Password"),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "* required";
                  }
                },
              ),
            ),
             Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextFormField(
                controller: _confirmPasswordController,
                   obscureText: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(  border: OutlineInputBorder(),labelText: "Confirm Password"),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "* required";
                  }
                  if (value.trim() != _passwordController.text.trim()) {
                    return "* password doesn't matched";
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
