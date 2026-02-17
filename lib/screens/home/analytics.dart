import 'package:borrow_tracker/services/auth.dart';
import 'package:flutter/material.dart';

class AnalyticsPage extends StatefulWidget {

 final Function(int) onScreenChange;
  AnalyticsPage({required this.onScreenChange});


  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: false,
            title: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                'Analytics',
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
                  onPressed: () => widget.onScreenChange(2),
                ),
                IconButton(
                  icon: Icon(Icons.person_rounded), 
                  onPressed: () => widget.onScreenChange(1),
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
                    onPressed: () {},
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.home_rounded), 
                  onPressed: () => widget.onScreenChange(0)
                ),
                IconButton(
                  icon: Icon(Icons.menu_rounded), 
                  onPressed: () {}
                ),
              ],
            ),
          ),
        );
  }
}