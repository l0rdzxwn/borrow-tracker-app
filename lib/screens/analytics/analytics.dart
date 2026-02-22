import 'package:borrow_tracker/models/UserData.dart';
import 'package:borrow_tracker/screens/analytics/PieGraph.dart';
import 'package:borrow_tracker/screens/home/BorrowForm.dart';
import 'package:borrow_tracker/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnalyticsPage extends StatefulWidget {

 final Function(int) onScreenChange;
  AnalyticsPage({required this.onScreenChange});


  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {

  Widget _buildLegendItem(String title, String count, Color color1, Color color2) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 5)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 4,
            width: 24,
            decoration: BoxDecoration(
              gradient: LinearGradient(
              colors: [color1, color2],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ), 
              borderRadius: BorderRadius.circular(2)
            ),
          ),
          const SizedBox(height: 12),
          Text(title, style: TextStyle(color: Colors.blueGrey[400], fontSize: 12)),
          const SizedBox(height: 4),
          Text(count, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    ),
  );
}

void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: BorrowForm(), // Your form UI
        );
      });
    }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<List<UserData>>(context);
              int total = userData.length;
              int lentCount = userData.where((x) => x.lendStatus == true).length;
              int borrowCount = userData.where((x) => x.lendStatus == false).length;


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
                    onPressed: () => _showSettingsPanel(),
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

          body: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        gradient: const LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [Color(0xFF467FEE), Color(0xFFAA66CE), Color(0xFFFF7F62)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF467FEE).withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.analytics_outlined, color: Colors.white.withOpacity(0.8)),
                              const Text('Active Items', style: TextStyle(color: Colors.white70, fontSize: 16)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${total}',
                            style: TextStyle(color: Colors.white, fontSize: 42, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
              
                    const SizedBox(height: 40),
                    
                    Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            height: 250,
                            child: PieGraph(lentCount: lentCount.toDouble(), borrowCount: borrowCount.toDouble(),),
                          ),
                          
                          Column(
                            children: [
                              Text(
                                "Balance",
                                style: TextStyle(color: Colors.blueGrey[400], fontSize: 14),
                              ),
                              Text(
                                "Ratio",
                                style: TextStyle(color: Colors.blueGrey[900], fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
              
                    const SizedBox(height: 40),
              
                    Row(
                      children: [
                        _buildLegendItem("Lent to Others", lentCount.toString(), Color(0xFF467FEE), Color(0xFFAA66CE)),
                        const SizedBox(width: 20),
                        _buildLegendItem("Borrowed", borrowCount.toString(), Color.fromARGB(255, 252, 91, 139),const Color(0xFFFF7F62)),
                      ],
                    ),
                  ],
                ),
              )
        );
  }
}