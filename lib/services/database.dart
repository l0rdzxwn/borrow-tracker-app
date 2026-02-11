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

  UserData _getData(DocumentSnapshot snapshot){
    var data = snapshot.data() as Map<String,dynamic>;
    return UserData(uid: uid ?? '', itemName: data['item-name'], personName: data['person-name'], lendStatus: data['lend-status']);
  }

  Stream<UserData> get userData {
    return collection.doc(uid).snapshots().map(_getData);
  }
}