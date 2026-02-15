import 'package:borrow_tracker/models/UserData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BorrowList extends StatefulWidget {
  const BorrowList({super.key});

  @override
  State<BorrowList> createState() => _BorrowListState();
}

class _BorrowListState extends State<BorrowList> {
  @override
  Widget build(BuildContext context) {

    final list = Provider.of<List<UserData>>(context);
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context,index){ 
        
        final item = list[index];
        
        return Padding(
        padding: const EdgeInsets.only(top: 8.0),
          child: Card(
            margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
            child: ListTile(
              leading: CircleAvatar(
                radius: 25.0,
                backgroundColor: item.lendStatus ? Colors.red[100] : Colors.green[100],
                child: Icon(
                  item.lendStatus ? Icons.outbox : Icons.move_to_inbox,
                  color: item.lendStatus ? Colors.red : Colors.green,
                ),
              ),
              title: Text(item.itemName, style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Person: ${item.personName}'),
              trailing: Icon(Icons.chevron_right, color: Colors.grey),
            ),
          ),
        );
      }
    );
    
  }
}