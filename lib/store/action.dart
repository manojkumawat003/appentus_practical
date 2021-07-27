

import 'dart:convert';

import 'package:appentus_demo/modal/authorsList.dart';
import 'package:appentus_demo/modal/loginData.dart';
import 'package:appentus_demo/screens/homePage.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:http/http.dart' as http;
import 'appState.dart';

ThunkAction<AppState> loginData(context,loginRes) {
  print('loginData api running');
  return (Store<AppState> store) async {
     if(loginRes !=null){
      store.dispatch(LoginData.fromJson(loginRes));
           Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => HomeScreen()),
  );
      }else{
        store.dispatch(LoginData());
      }
    
  };
}


//authors list

ThunkAction<AppState> fetchAuthorsList(context) {
  print('fetchAuthorsList api running');
  return (Store<AppState> store) async {
    var url = Uri.parse('https://picsum.photos/v2/list');
//now fetch data from server
    
      var response =
          await http.get(url);
      print(['fetchAuthorsList api res', response.body]);
      if (response.statusCode == 200) {
        var newResponse = jsonDecode(response.body);
              print(['responseBody', newResponse]);
              store.dispatch(AuthorsList.fromJson({"authorData":newResponse}));
    }      else {
        print(['parseResaon', response.persistentConnection]);
        if (response.statusCode >= 500) {
       
          return false;
        }
      }
    
  };
}



