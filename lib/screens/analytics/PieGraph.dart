import 'package:borrow_tracker/models/FirebaseUser.dart';
import 'package:borrow_tracker/models/UserData.dart';
import 'package:borrow_tracker/services/database.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';

class PieGraph extends StatelessWidget {

  final double lentCount;
  final double borrowCount;
  
  const PieGraph({
    super.key,
    required this.lentCount,
    required this.borrowCount
  });


  @override
  Widget build(BuildContext context) {

    final userID = Provider.of<FirebaseUser?>(context);

    
        return PieChart(
          PieChartData(
            sectionsSpace: 4,
            centerSpaceRadius: 60, 
            sections: [
              PieChartSectionData(
                value: lentCount,
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
                value: borrowCount,
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
} 