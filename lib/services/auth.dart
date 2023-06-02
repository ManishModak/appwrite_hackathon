import 'package:shared_preferences/shared_preferences.dart';
import 'package:appwrite/appwrite.dart';

class AuthService {

  late Account account ;
  late Databases databases;
  late Teams teams;

  AuthService() {

    Client client = Client()
        .setEndpoint('https://cloud.appwrite.io/v1')  // Your Appwrite Endpoint
        .setProject('6479bcbb10618eda232a');          // Your project ID

    account = Account(client);
    databases = Databases(client);
    teams = Teams(client);
  }

//   bool checkMembership(email){
//     try{
//       Future result = teams.get(teamId: "6479dad5cc82ac9cf6f3");
//       result.asMap().forEach((i, value) {
//         pr
//
//
//       return session.$id;
//     }catch(e){
//       return null;
//     }
//
// return false;
//   }

  // Admin? _adminFromFirebaseUser(Se) {
  //   return Admin(uid: user.uid) ;
  // }

  Future signInWithEmailAndPassword(String email,String password) async {
    try{
      final session = await account.createEmailSession(email: email, password: password) ;
      if (session.$id.isNotEmpty) {
        // Save the email to SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('email', email);
      }
      return session.$id;
    }catch(e){
      return null;
    }
  }

  Future registerWithEmailAndPassword(String email,String password) async{
    try{
      final user = await account.create(userId: ID.unique(),email: email, password: password) ;

      if (user.$id.isNotEmpty) {
        // Save the email to SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('email', email);
      }
      return user.$id;
    }catch(e){
      return null;
    }
  }
}