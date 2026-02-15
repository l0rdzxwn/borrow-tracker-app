import 'package:borrow_tracker/models/UserData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseServices{
  
  final String? uid;
  DatabaseServices({this.uid});

  final CollectionReference collection = FirebaseFirestore.instance.collection('itemsDB');

  Future insertRecord(String name, String item) async{
    final User? user = FirebaseAuth.instance.currentUser;

    return await collection.add({
        'uid': user?.uid, 
        'item-name': item, 
        'person-name': name, 
        'lend-status': false
      
    });
  }

  List<UserData> _getData(QuerySnapshot snapshot){

    return snapshot.docs.map((row){
      return UserData(
        uid: row.get('uid'), 
        itemName: row.get('item-name'), 
        personName: row.get('person-name'), 
        lendStatus: row.get('lend-status')
      );
    }).toList();
  }

  Stream<List<UserData>> get userData {
    return collection.where('uid',isEqualTo: uid).snapshots().map(_getData);
  }


}