import 'package:borrow_tracker/screens/extras/Loading.dart';
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
  bool loadingStatus = false;
  String error = ''; // Safety net for Firebase errors

  @override
  Widget build(BuildContext context) {
    return loadingStatus ? Loading() : Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton.icon(
            icon: Icon(Icons.login_rounded, color: Color(0xFFAA66CE)),
            label: Text('Login', style: TextStyle(color: Color(0xFFAA66CE), fontWeight: FontWeight.bold)),
            onPressed: () => widget.toggleView(),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Create Account', style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w900, color: Colors.blueGrey[900])),
                Text('Join the Borrow Tracker community', style: TextStyle(fontSize: 16.0, color: Colors.grey)),
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
                
                // THE DASHBOARD-MATCHED GRADIENT BUTTON
                InkWell(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() => loadingStatus = true);
                      dynamic result = await AuthServices().signUp(email, password);
                      if (result == null) {
                        setState(() {
                          error = 'Please supply a valid email';
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
                    child: Center(
                      child: Text('Register', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
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