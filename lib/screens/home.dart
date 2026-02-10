import 'package:borrow_tracker/screens/BorrowForm.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: BorrowForm(), // Your form UI
        );
      });
    }

    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text('My Borrowed Items'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showSettingsPanel(),
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () { /* BACKEND TASK: Sign Out */ },
          )
        ],
      ),// BACKEND TASK: This will be your StreamProvider consumer
    );
  }
}