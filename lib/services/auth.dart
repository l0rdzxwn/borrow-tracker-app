import 'package:firebase_auth/firebase_auth.dart';
import 'package:borrow_tracker/models/FirebaseUser.dart';

class AuthServices{

final FirebaseAuth _authInstance = FirebaseAuth.instance;

FirebaseUser? _getUid(User? user){
  return user != null ? FirebaseUser(uid: user.uid) : null;
}

Stream<FirebaseUser?> get userID {
  return _authInstance.authStateChanges().map(_getUid);
}

Future signIn(String email, String password) async{
  try{
    await _authInstance.signInWithEmailAndPassword(email: email, password: password);
  }catch(ex){
    print(ex.toString());
  }
}

Future signUp(String email, String password) async{
  await _authInstance.createUserWithEmailAndPassword(email: email, password: password);
}

Future signOut() async{
  await _authInstance.signOut();
}

}