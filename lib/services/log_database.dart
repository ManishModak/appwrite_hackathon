import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:intl/intl.dart';

class LogDatabase {
  late final Client _client;
  late final Databases _database;
  String logsDId = '647ad1a8c6147fd612a1';
  String logsCollId = '647ad4ee0dffdf01fdae';
  String userDId = '647a0fa72e02c1bdcc70';
  String studCollId = '647ad7cd03478b4f9497';

  LogDatabase() {
    _client = Client()
        .setEndpoint('https://cloud.appwrite.io/v1')
        .setProject('6479bcbb10618eda232a');
    _database = Databases(_client);
  }

  Future<String> addLog({required String id}) async {
    DateTime currentTime = DateTime.now();
    String formattedTime = DateFormat('HH:mm:ss').format(currentTime);
    String formattedDate = DateFormat('yyyyMMdd').format(currentTime);
    String studName;
    String roomNo;
    String mobileNo;
    //check if id exists in database
    try {
      final stud = await _database.getDocument(
          databaseId: userDId, collectionId: studCollId, documentId: id);
      studName = stud.data['name'];
      roomNo = stud.data['roomNo'];
      mobileNo = stud.data['mobileNo'];
      //print('stud found');
    } catch (e) {
      //print('Stud not fount $e');
      return "Student does not exist";
    }

    //if student found check if student is gone out
    try {
      final result = await _database.listDocuments(
          databaseId: logsDId,
          collectionId: logsCollId,
          queries: [
            Query.equal('id', id),
            Query.orderDesc('\$createdAt'),
            Query.limit(1)
          ]);
      bool isStudOut;
      if (result.total == 0) {
        //no out entry
        //print('student is in.no out entry');
        isStudOut = false;
      } else {
        if (result.documents[0].data['inTime'] == 'null') {
          //print('student is still out');
          isStudOut = true;
        } else {
          //print('student is returned');
          isStudOut = false;
        }
      }
      // result.documents[0].data.forEach((key, value) {
      //   print("$key -> $value");});
      // print(result.documents[0].data);

      //update record if student is out
      if (isStudOut) {
        await _database.updateDocument(
            databaseId: logsDId,
            collectionId: logsCollId,
            documentId: result.documents[0].$id,
            data: {'inTime': formattedTime});
        //print('updated record');
        return "Student In Record created";
      } else {
        //create new record in log
        var formattedId =
            formattedDate + formattedTime.replaceAll(':', '') + id;
        await _database.createDocument(
            databaseId: logsDId,
            collectionId: logsCollId,
            documentId: formattedId,
            data: {
              'id': id,
              'date': formattedDate,
              'outTime': formattedTime,
              'name': studName,
              'roomNo': roomNo,
              'mobileNo': mobileNo,
              'inTime': 'null'
            });
        //print('created record');
        return "Student Out Record created";
      }
    } catch (e) {
      // print(e);
      return 'An error occured';
    }
  }

  Future<List<Document>> getDocuments() async {
    DateTime currentTime = DateTime.now();
    String formattedDate = DateFormat('yyyyMMdd').format(currentTime);
    final response = await _database
        .listDocuments(collectionId: logsCollId, databaseId: logsDId, queries: [
      Query.orderDesc('\$createdAt'),
      Query.limit(100),
      Query.equal('date', formattedDate)
    ]);

    return response.documents;
  }

  Future<List<Document>> getNotReturned() async {
    final response = await _database.listDocuments(
        collectionId: logsCollId,
        databaseId: logsDId,
        queries: [
          Query.orderDesc('\$createdAt'),
          Query.equal('inTime', 'null')
        ]);
    return response.documents;
  }
}
