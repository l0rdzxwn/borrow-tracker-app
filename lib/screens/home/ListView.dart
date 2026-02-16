import 'package:borrow_tracker/models/UserData.dart';
import 'package:borrow_tracker/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BorrowList extends StatefulWidget {
  const BorrowList({super.key});

  @override
  State<BorrowList> createState() => _BorrowListState();
}

class _BorrowListState extends State<BorrowList> {
  bool _isFilled = false;
  int? _pressedIndex;
  DateTime? _startTime;
  
  @override
  Widget build(BuildContext context) {

    final list = Provider.of<List<UserData>>(context);
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context,index){ 

        final item = list[index];

       return Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
  child: Container( // Using Container for more control over the border
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.grey[100]!, width: 1.5), // Subtle border
    ),
    child: ClipRRect( // Clips the "Delete" overlay to the container's rounded corners
      borderRadius: BorderRadius.circular(16),
      child: GestureDetector(
        onLongPress: () {
          setState(() { _pressedIndex = index; });
          _startTime = DateTime.now();
        },
        onLongPressUp: () async {
          setState(() { _pressedIndex = null; });
          final duration = DateTime.now().difference(_startTime!);

          if(duration.inMilliseconds >= 1500){
            await DatabaseServices(uid: item.docID).deleteRecord();
          }
        },
        child: Stack(
          children: [
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: item.lendStatus ? Color(0xFFFFEBEE) : Color(0xFFE8F5E9),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  item.lendStatus ? Icons.arrow_outward_rounded : Icons.south_west_rounded,
                  color: item.lendStatus ? Colors.redAccent : Colors.green,
                  size: 24,
                ),
              ),
              title: Text(
                item.itemName, 
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blueGrey[900])
              ),
              subtitle: Text(
                'With ${item.personName}', 
                style: TextStyle(color: Colors.grey[600], fontSize: 14)
              ),
              trailing: Icon(Icons.chevron_right_rounded, color: Colors.grey[400]),
            ),
            
            // DELETE OVERLAY
            AnimatedPositioned(
              duration: Duration(milliseconds: 1500),
              curve: Curves.fastOutSlowIn,
              top: 0,
              bottom: 0,
              left: _pressedIndex == index ? 0 : MediaQuery.of(context).size.width,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.redAccent, Colors.red[700]!],
                  ),
                ),
                child: Center(
                  child: Text(
                    'DELETE RECORD',
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w900,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  ),
);
      }   
    );  
  }
}