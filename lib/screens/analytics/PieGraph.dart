import 'package:borrow_tracker/models/FirebaseUser.dart';
import 'package:borrow_tracker/models/UserData.dart';
import 'package:borrow_tracker/services/database.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';

class PieGraph extends StatelessWidget {
 
  
  const PieGraph({
    super.key
  });


  @override
  Widget build(BuildContext context) {

    final userID = Provider.of<FirebaseUser?>(context);

    return StreamProvider<List<UserData>>.value(
      initialData: [],
      value: DatabaseServices(uid: userID?.uid).userData,
      builder: (context, snapshot) {

        final userData = Provider.of<List<UserData>>(context); 
        int lentCount = userData.where((e) => e.lendStatus == true,).length;
        int borrowCount = userData.where((e) => e.lendStatus == false,).length;
        
        return PieChart(
          PieChartData(
            sectionsSpace: 4,
            centerSpaceRadius: 60, 
            sections: [
              PieChartSectionData(
                value: lentCount.toDouble(),
                title: 'Lent',
                radius: 25, 
                showTitle: false, 
                gradient: const LinearGradient(
                  colors: [Color(0xFF467FEE), Color(0xFFAA66CE)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              
              PieChartSectionData(
                value: borrowCount.toDouble(),
                title: 'Borrowed',
                radius: 25,
                showTitle: false,
                gradient: const LinearGradient(
                  colors: [Color.fromARGB(255, 252, 91, 139), Color(0xFFFF7F62)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ],
            pieTouchData: PieTouchData(
              touchCallback: (FlTouchEvent event, pieTouchResponse) {
              },
            ),
          ),
        );
      }
    );
  }
} 