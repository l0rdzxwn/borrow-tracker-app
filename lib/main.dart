import 'package:borrow_tracker/models/FirebaseUser.dart';
import 'package:borrow_tracker/screens/home/mainPage.dart';
import 'package:borrow_tracker/services/auth.dart';
import 'package:borrow_tracker/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Borrow Tracker',
      home: StreamProvider<FirebaseUser?>.value(
        initialData: null,
        value: AuthServices().userID,
        builder: (context, asyncSnapshot) {
          return Wrapper();
        }
      ),
    );
  }
}
