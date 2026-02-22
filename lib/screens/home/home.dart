import 'package:borrow_tracker/models/FirebaseUser.dart';
import 'package:borrow_tracker/models/UserData.dart';
import 'package:borrow_tracker/screens/analytics/analytics.dart';
import 'package:borrow_tracker/screens/home/mainPage.dart';
import 'package:borrow_tracker/screens/home/profile.dart';
import 'package:borrow_tracker/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _currentScreen = 0;
 
  @override
  Widget build(BuildContext context) {
     final user = Provider.of<FirebaseUser?>(context);
    Widget toggleScreens(){
      switch(_currentScreen){
        case 0:
          return MainPage(onScreenChange: (val) => setState(() { _currentScreen = val; }));
        case 1:
          return ProfilePage(onScreenChange: (val) => setState(() { _currentScreen = val; }));
        case 2: 
          return AnalyticsPage(onScreenChange: (val) => setState(() { _currentScreen = val; }));
        default:
          return MainPage(onScreenChange: (val) => setState(() { _currentScreen = val; }));
      }
    }

    return StreamProvider<List<UserData>>.value(
      initialData: [],
      value: DatabaseServices(uid: user?.uid).userData,
      builder: (context, asyncSnapshot) {
        return toggleScreens();
      }
    );
  }
}