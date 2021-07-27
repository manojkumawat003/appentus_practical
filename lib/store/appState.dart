import 'package:appentus_demo/modal/authorsList.dart';
import 'package:appentus_demo/modal/loginData.dart';

class AppState {
   LoginData loggedInUserData;
   LoginData get loginData => loggedInUserData;
 
   AuthorsList _authorsList;
   AuthorsList get authorsList => _authorsList;
  AppState( this.loggedInUserData,this._authorsList);
  
}