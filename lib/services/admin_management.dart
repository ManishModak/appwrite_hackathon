import 'package:appwrite/appwrite.dart';
import 'dart:convert';

class AdminManagement {
  final Client client = Client();
  late final Functions functions = Functions(client);
  String functionID = "6482c6f05c2eb7278473";

  mainDatabase() {
    client
        .setEndpoint(
            'https://cloud.appwrite.io/v1') // Replace with your Appwrite endpoint
        .setProject(
            '6479bcbb10618eda232a'); // Replace with your Appwrite project ID
  }

  Future<String> newAdmin({required String email}) async {
    client
        .setEndpoint(
            'https://cloud.appwrite.io/v1') // Replace with your Appwrite endpoint
        .setProject(
            '6479bcbb10618eda232a'); // Replace with your Appwrite project ID

    var data = {'email': email};

    var jsonString = jsonEncode(data);

    try {
      final result = await functions.createExecution(
          functionId: functionID, data: jsonString);

      final response = json.decode(result.response);
      // print(response['msg']);
      return response['msg'];
    } catch (e) {
      // print("error here");
      // print(e);
    }
    ;
    final result = await functions.createExecution(
        functionId: functionID, data: jsonString);

    // print('jsonString');
// print(result);
    final response = json.decode(result.response);
// print(response['msg']);
    return response['msg'];
  }
}
