import 'package:appentus_demo/modal/authorsList.dart';
import 'package:appentus_demo/modal/loginData.dart';
import 'package:appentus_demo/screens/auth/authScreen.dart';
import 'package:appentus_demo/store/appState.dart';
import 'package:appentus_demo/store/reducer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

final store = new Store<AppState>(reducerUser,
    initialState: AppState(LoginData(),AuthorsList()),
    middleware: [thunkMiddleware]);

Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
    final directory = await getApplicationDocumentsDirectory();
   Hive.init(directory.path);

 await Hive.openBox('usersList');
  runApp(
    StoreProvider<AppState>(
    store: store,
      child:
    MyApp()));
}

class MyApp extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Appentus Demo',
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
      home: AuthScreen(),
    );
  }
}

