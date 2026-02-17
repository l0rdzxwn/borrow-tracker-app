import 'package:borrow_tracker/models/FirebaseUser.dart';
import 'package:borrow_tracker/screens/authenticate/authentication.dart';
import 'package:borrow_tracker/screens/home/home.dart';
import 'package:borrow_tracker/screens/home/mainPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {

    final _userStatus = Provider.of<FirebaseUser?>(context);
    return _userStatus == null ? Authenticate() : Home();
  }
}