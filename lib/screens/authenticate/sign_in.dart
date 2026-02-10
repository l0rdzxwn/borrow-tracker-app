import 'package:flutter/material.dart';

// Use this structure for both SignIn and Register
class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({required this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
            icon: Icon(Icons.person, color: Colors.white),
            label: Text('Register', style: TextStyle(color: Colors.white)),
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
                child: Text('Sign In'),
                onPressed: () {
                   // BACKEND TASK: Call your Auth service here
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}