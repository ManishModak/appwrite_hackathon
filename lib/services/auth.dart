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

  Future<bool> checkMembership(email) async {
    try{
      final result = await teams.listMemberships(teamId: "6479dad5cc82ac9cf6f3");
      for(int i=0 ;i<result.total;i++){
        if(result.memberships[i].userEmail == email){
          return true;
        }
      }
      return false;
    }catch(e){
      return false;
    }

  }



  Future signInWithEmailAndPassword(String email,String password) async {
    try{
      final session = await account.createEmailSession(email: email, password: password) ;
      if (session.$id.isNotEmpty) {
        // Save the email to SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('email', email);
      }
      if(await checkMembership(email)){
        return session.$id;
      }
      else{
        return "unauthorised";
      }

    }catch(e){
      return "invalid";
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