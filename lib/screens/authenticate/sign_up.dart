import 'package:borrow_tracker/services/auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({required this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Borrow Tracker'),
        actions: [
          TextButton.icon(
            icon: Icon(Icons.person, color: Colors.black),
            label: Text('Login', style: TextStyle(color: Colors.black)),
            onPressed: () => widget.toggleView(),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(hintText: 'Email'),
                onChanged: (val) => setState(() => email = val),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(hintText: 'Password'),
                obscureText: true,
                onChanged: (val) => setState(() => password = val),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                child: Text('Sign up'),
                onPressed: () async{
                   await AuthServices().signUp(email, password);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}