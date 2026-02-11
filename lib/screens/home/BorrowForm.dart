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
    
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text('New Record', style: TextStyle(fontSize: 18.0)),
          TextFormField(
            decoration: InputDecoration(labelText: 'Item Name'),
            validator: (val) => val!.isEmpty ? 'Please enter an item name.' : null, 
            onChanged: (val) => setState(() => _item = val),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Person Name'),
            validator: (val) => val!.isEmpty ? 'Please enter a person name.' : null, 
            onChanged: (val) => setState(() => _person = val),
          ),
          SwitchListTile(
            title: Text('Did you lend this?'),
            value: _isLent,
            onChanged: (val) => setState(() => _isLent = val),
          ),
          ElevatedButton(
            child: Text('Save to Database'),
            onPressed: () async{
              if(_formKey.currentState!.validate()){
                await DatabaseServices().insertRecord(_person,_item);
              }
            },
          )
        ],
      ),
    );
  }
}
