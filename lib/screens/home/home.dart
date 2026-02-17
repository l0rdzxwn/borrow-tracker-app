import 'package:borrow_tracker/screens/home/analytics.dart';
import 'package:borrow_tracker/screens/home/mainPage.dart';
import 'package:borrow_tracker/screens/home/profile.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _currentScreen = 0;

  @override
  Widget build(BuildContext context) {
    
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

    return toggleScreens();
  }
}