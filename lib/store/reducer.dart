import 'package:appentus_demo/modal/authorsList.dart';
import 'package:appentus_demo/modal/loginData.dart';

import 'appState.dart';

AppState reducerUser(AppState prev, dynamic action) {
  if (action is LoginData) {
    AppState newAppState = new AppState(
      action,prev.authorsList
        );
    return newAppState;
  } else if (action is AuthorsList) {
    AppState newAppState = new AppState(
     prev.loggedInUserData,
      action
        );
    return newAppState;
  } 
  else {
    return prev;
  }
}
