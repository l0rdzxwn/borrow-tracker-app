import 'package:borrow_tracker/models/UserData.dart';
import 'package:borrow_tracker/screens/home/BorrowForm.dart';
import 'package:borrow_tracker/screens/home/ListView.dart';
import 'package:borrow_tracker/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {

  final Function(int) onScreenChange;
  MainPage({required this.onScreenChange});

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

    final userData = Provider.of<List<UserData>>(context);
    int total = userData.length;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            'Home',
            style: TextStyle(
              color: Colors.blueGrey[900],
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        actions: [
          
          // LOGOUT BUTTON
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: Icon(Icons.logout_rounded, color: Colors.blueGrey[400]),
              onPressed: () async { 
                await AuthServices().signOut(); 
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.bar_chart_rounded), 
              onPressed: () {
                  onScreenChange(1);
              },
            ),
            
            Container(
              margin: EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [Color(0xFF467FEE), Color(0xFFAA66CE), Color(0xFFFF7F62)],
                ),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(Icons.add_rounded, color: Colors.white, size: 26),
                onPressed: () => _showSettingsPanel(),
              ),
            ),
            IconButton(
              icon: Icon(Icons.home_rounded), 
              onPressed: () => onScreenChange(0)
            ),
            
          ],
        ),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 160,
            margin: EdgeInsets.all(20.0),
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [Color(0xFF467FEE), Color(0xFFAA66CE), Color(0xFFFF7F62)],
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF467FEE).withOpacity(0.3),
                  blurRadius: 20,
                  offset: Offset(0, 10),
                )
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.analytics_outlined, color: Colors.white70, size: 20),
                        SizedBox(width: 8),
                        Text('Total Records', style: TextStyle(color: Colors.white, fontSize: 16)),
                      ],
                    ),
                    Text('${total}', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                  ],
                ),
                Divider(color: Colors.white24),
                InkWell(
                  onTap: () => _showSettingsPanel(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Add New Record', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(color: Colors.white24, shape: BoxShape.circle),
                        child: Icon(Icons.add, color: Colors.white, size: 20),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              'Recorded Logs',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.blueGrey[900]),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
                  child: BorrowList(), 
          ),
        ],
      )
    );
  }
}