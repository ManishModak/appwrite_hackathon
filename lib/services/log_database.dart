import 'package:appwrite/appwrite.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:mat_security/services/main_database.dart';

class LogDatabase {
  final Client _client = Client();
  late final Databases _database;
  String dID = '647a0fa72e02c1bdcc70';

  LogDatabase() {
    _client
        .setEndpoint('https://cloud.appwrite.io/v1') // Replace with your Appwrite endpoint
        .setProject('6479bcbb10618eda232a'); // Replace with your Appwrite project ID

    _database = Databases(_client);
  }

  Future<void> addLog({required String id}) async {
    DateTime currentTime = DateTime.now();
    String formattedTime = DateFormat('HH:mm:ss').format(currentTime);
    String formattedDate = DateFormat('yyyy:MM:dd').format(currentTime);

    Map<String, dynamic> data;

    final snapshot = await _database.listDocuments(
      collectionId: formattedDate,
      databaseId: dID,
    );

    for (var doc in snapshot.documents) {
      Map<String, dynamic> data = doc.data;
      if (data['id'] == id && data['inTime'] == null) {
        await _database.updateDocument(
          collectionId: formattedDate,
          databaseId: dID,
          documentId: id,
          data: {'inTime': formattedTime},
        );
        return;
      }
    }

    MainDatabase student = MainDatabase();
    data = await student.getInfo(id: id);

    Map<String, dynamic> stdData = {
      'id': id,
      'roomNo': data['roomNo'],
      'name': data['name'],
      'outTime': formattedTime,
      'inTime': null,
    };
    await _database.createDocument(
      collectionId: formattedDate,
      databaseId: dID,
      documentId: ID.unique(),
      data: stdData,
    );

    if (kDebugMode) {
      print('done');
    }
  }
}
