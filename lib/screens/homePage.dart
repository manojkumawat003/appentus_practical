import 'package:appentus_demo/screens/map/mapHome.dart';
import 'package:flutter/material.dart';

import 'authorsList.dart';
import 'drawerScreen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

int _selectedIndex = 0;

 List<Widget> _widgetOptions = <Widget>[
MapHomeScreen(),  AuthorsListScreen(),
 
];

void _onItemTapped(int index) {
  setState(() {
    _selectedIndex = index;
  });
}




 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Appentus Project'),
    ),
    drawer: Drawer(child:DrawerScreen() ,),
    body: Center(
      child: _widgetOptions.elementAt(_selectedIndex),
    ),
    bottomNavigationBar: BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'Map',
          backgroundColor: Colors.red,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.note),
          label: 'Authors',
          backgroundColor: Colors.green,
        ),
     
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
    ),
  );
}
}