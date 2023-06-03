import 'package:appwrite/appwrite.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:mat_security/services/main_database.dart';

class LogDatabase {

  late final Client _client;
  late final Databases _database;
  String dID = '647ad1a8c6147fd612a1';

  LogDatabase() {
    _client = Client().setEndpoint('https://cloud.appwrite.io/v1').setProject('6479bcbb10618eda232a');
    _database = Databases(_client);
  }

  Future<void> addLog({required String id}) async {
    DateTime currentTime = DateTime.now();
    String formattedTime = DateFormat('HH:mm:ss').format(currentTime);
    String formattedDate = DateFormat('yyyyMMdd').format(currentTime);

    final snapshot = await _database.listDocuments(
      collectionId: 'logs_$formattedDate',
      databaseId: dID,
    );

    for (var doc in snapshot.documents) {
      if (doc.data['id'] == id && doc.data['inTime'] == null) {
        await _database.updateDocument(
          collectionId: 'logs_$formattedDate',
          databaseId: dID,
          documentId: id,
          data: {'inTime': formattedTime},
        );
        return;
      }
    }

    MainDatabase student = MainDatabase();

    Map<String, dynamic> data = await student.getInfo(id: id);

    Map<String, dynamic> stdData = {
      'id': id,
      'roomNo': data['roomNo'],
      'name': data['name'],
      'outTime': formattedTime,
      'inTime': null,
    };

    try {
      await _database.createDocument(
        collectionId: 'logs_$formattedDate',
        databaseId: dID,
        documentId: DateTime.now().toString(),
        data: stdData,
      );

      if (kDebugMode) {
        print('done');
      }
    } catch (e) {
      print('Error adding log: $e');
    }
  }
}
