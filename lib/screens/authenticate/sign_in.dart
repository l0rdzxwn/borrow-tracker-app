import 'package:borrow_tracker/screens/extras/Loading.dart';
import 'package:borrow_tracker/services/auth.dart';
import 'package:flutter/material.dart';

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
  bool loadingStatus = false;
  String error = ''; // To show login errors

  @override
  Widget build(BuildContext context) {
    return loadingStatus ? Loading() : Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton.icon(
            icon: Icon(Icons.person_add_rounded, color: Color(0xFFAA66CE)),
            label: Text('Register', style: TextStyle(color: Color(0xFFAA66CE), fontWeight: FontWeight.bold)),
            onPressed: () => widget.toggleView(),
          )
        ],
      ),
      body: SingleChildScrollView( // Prevents bottom overflow when keyboard opens
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Welcome Back', style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w900, color: Colors.blueGrey[900])),
                Text('Sign in to track your items', style: TextStyle(fontSize: 16.0, color: Colors.grey)),
                SizedBox(height: 40.0),
                
                // EMAIL FIELD
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                  onChanged: (val) => setState(() => email = val),
                ),
                SizedBox(height: 20.0),
                
                // PASSWORD FIELD
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock_outline_rounded),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  obscureText: true,
                  validator: (val) => val!.length < 6 ? 'Enter a password 6+ chars long' : null,
                  onChanged: (val) => setState(() => password = val),
                ),
                SizedBox(height: 30.0),
                
                // GRADIENT SIGN IN BUTTON
                InkWell(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() => loadingStatus = true);
                      dynamic result = await AuthServices().signIn(email, password);
                      if (result == null) {
                        setState(() {
                          error = 'Could not sign in with those credentials';
                          loadingStatus = false;
                        });
                      }
                    }
                  },
                  child: Container(
                    height: 55,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF467FEE), Color(0xFFAA66CE), Color(0xFFFF7F62)],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(child: Text('Sign In', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16))),
                  ),
                ),
                
                SizedBox(height: 12.0),
                Text(error, style: TextStyle(color: Colors.red, fontSize: 14.0)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}