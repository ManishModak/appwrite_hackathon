import 'package:mat_security/services/admin.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance ;

  Admin? _adminFromFirebaseUser(User user) {
    return Admin(uid: user.uid) ;
  }

  Future signInWithEmailAndPassword(String email,String password) async {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password) ;
      print(result) ;
      User? user = result.user;
      return _adminFromFirebaseUser(user!);
    }catch(e){
      return null;
    }
  }

  Future registerWithEmailAndPassword(String email,String password) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user ;
      return _adminFromFirebaseUser(user!) ;
    }catch(e) {
      // print(e.toString());
      return null ;
    }
  }
}