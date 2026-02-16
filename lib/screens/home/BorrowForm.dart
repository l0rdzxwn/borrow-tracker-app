import 'package:borrow_tracker/models/FirebaseUser.dart';
import 'package:borrow_tracker/models/UserData.dart';
import 'package:borrow_tracker/services/database.dart';
import 'package:borrow_tracker/screens/extras/Loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BorrowForm extends StatefulWidget {
  @override
  _BorrowFormState createState() => _BorrowFormState();
}

class _BorrowFormState extends State<BorrowForm> {
  final _formKey = GlobalKey<FormState>();
  String _item = '';
  String _person = '';
  bool _isLent = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 550,
      padding: EdgeInsets.only(
        top: 20,
        left: 25,
        right: 25,
        bottom: MediaQuery.of(context).viewInsets.bottom + 30, 
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10)))),
              SizedBox(height: 15),
              Text('New Record', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.blueGrey[900])),
              SizedBox(height: 25),
              
              // ITEM FIELD: Matched to the Coral/Orange part of your gradient
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Item name',
                  prefixIcon: Icon(Icons.inventory_2_outlined, color: Color(0xFFFF7F62)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Color(0xFFFF7F62), width: 2)),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                validator: (value) => value!.isEmpty ? 'Please enter the item name' : null,
                onChanged: (val) => setState(() => _item = val),
              ),
              SizedBox(height: 20),
              
              // PERSON FIELD: Matched to the Purple part of your gradient
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Person name',
                  prefixIcon: Icon(Icons.person_outline_rounded, color: Color(0xFFAA66CE)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Color(0xFFAA66CE), width: 2)),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                validator: (value) => value!.isEmpty ? 'Please enter the person name' : null,
                onChanged: (val) => setState(() => _person = val),
              ),
              SizedBox(height: 20),
              
              // LEND STATUS: Clean and matched
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text('Did you lend this?', style: TextStyle(fontWeight: FontWeight.w600)),
                activeColor: Color(0xFF467FEE), // Matched to the Blue part of your gradient
                value: _isLent,
                onChanged: (val) => setState(() => _isLent = val),
              ),
              SizedBox(height: 5),
              
              // THE SAVE BUTTON: Full Gradient to match Total Records
              InkWell(
                onTap: () async {
                  if(_formKey.currentState!.validate()){
                    await DatabaseServices().insertRecord(_person, _item, _isLent);
                    Navigator.pop(context);
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
                  child: Center(child: Text('Add Record', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16))),
                  
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
