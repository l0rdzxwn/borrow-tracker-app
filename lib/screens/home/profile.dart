import 'package:borrow_tracker/services/auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {

  final Function(int) onScreenChange;
  ProfilePage({required this.onScreenChange});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  Widget _buildMenuTile({
    required IconData icon, 
    required String title, 
    required VoidCallback onTap, 
    Color? textColor, 
    Color? iconColor
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor ?? Color(0xFF467FEE)),
      title: Text(title, style: TextStyle(color: textColor ?? Colors.black87)),
      trailing: Icon(Icons.chevron_right, size: 20, color: Colors.grey),
      onTap: onTap,
    );
  }

  // Toggle Row
  Widget _buildToggleTile({
    required IconData icon, 
    required String title, 
    required bool value
  }) {
    return ListTile(
      leading: Icon(icon, color: Color(0xFF467FEE)),
      title: Text(title),
      trailing: Switch(
        value: value, 
        onChanged: (v) { 
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Coming soon"),
                content: Text("This feature is not available right now."),
                actions: [
                  TextButton(
                    child: Text("OK"),
                    onPressed: () => Navigator.of(context).pop(), // Closes the dialog
                  ),
                ],
              );
            },
          );
        }, // You'll handle state later
        activeColor: Color(0xFF467FEE),
      ),
    );
  }


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
                'Profile',
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


          body: CustomScrollView(
        slivers: [
          // 1. Minimalist Header
          SliverAppBar(
            expandedHeight: 180,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF467FEE), Color(0xFFAA66CE), Color(0xFFFF7F62)],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person_outline, size: 50, color: Color(0xFF467FEE)),
                    ),
                    SizedBox(height: 12),
                    Text(
                      "Habit Warrior",
                      style: TextStyle(
                        color: Colors.white, 
                        fontSize: 22, 
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 2. Settings List
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Account Settings", 
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.grey[800])
                  ),
                  SizedBox(height: 15),
                  
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.grey[300]!)
                    ),
                    child: Column(
                      children: [
                        _buildMenuTile(
                          icon: Icons.edit_outlined, 
                          title: "Edit Display Name", 
                          onTap: () {}
                        ),
                        Divider(height: 1, indent: 20, endIndent: 20),
                        
                        // Replaced Reminders with Appearance
                        _buildToggleTile(
                          icon: Icons.dark_mode_outlined, 
                          title: "Dark Mode", 
                          value: false
                        ),
                        Divider(height: 1, indent: 20, endIndent: 20),
                        
                        _buildMenuTile(
                          icon: Icons.help_outline, 
                          title: "Support & Feedback", 
                          onTap: () {}
                        ),
                        Divider(height: 1, indent: 20, endIndent: 20),
                        
                        _buildMenuTile(
                          icon: Icons.logout_rounded, 
                          title: "Sign Out", 
                          textColor: Colors.redAccent,
                          iconColor: Colors.redAccent,
                          onTap: () {} // Plug AuthServices().signOut() here
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
        );
    }
}