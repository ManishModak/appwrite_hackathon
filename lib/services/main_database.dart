import 'package:appwrite/appwrite.dart';

class MainDatabase {
  final Client _client = Client();
  late final Databases _database = Databases(_client);
  String dID = '647a0fa72e02c1bdcc70';
  String cID = '647ad7cd03478b4f9497';

  MainDatabase() {
    _client
        .setEndpoint('https://cloud.appwrite.io/v1') // Replace with your Appwrite endpoint
        .setProject('6479bcbb10618eda232a'); // Replace with your Appwrite project ID
  }

  Future<void> addStudent({
    required String id,
    required String name,
    required String room,
    required String branch,
    required String mobile,
    required String imageFileId,
  }) async {
    await _database.createDocument(
      collectionId: cID,
      databaseId: dID,
      documentId: id,
      data: {
        'id': id,
        'name': name,
        'roomNo': room,
        'branch': branch,
        'mobileNo': mobile,
        'imageFileId': imageFileId,
      },
    );
  }

  Future<Map<String, dynamic>> getInfo({required String id}) async {
    final document = await _database.getDocument(
      collectionId: cID,
      documentId: id,
      databaseId: dID,
    );
    Map<String, dynamic> data = document.data;
    return data;
  }

  Future<Map<String, dynamic>> updateRoom({required String id, required String room}) async {
    final document = await _database.updateDocument(
      collectionId: cID,
      documentId: id,
      databaseId: dID,
      data: {'roomNo': room},
    );
    Map<String, dynamic> data = document.data;
    return data;
  }

  Future<Map<String, dynamic>> updateBranch({required String id, required String branch}) async {
    final document = await _database.updateDocument(
      databaseId: dID,
      collectionId: cID,
      documentId: id,
      data: {'branch': branch},
    );
    Map<String, dynamic> data = document.data;
    return data;
  }

  Future<Map<String, dynamic>> deleteStudent({required String id}) async {
    final document = await _database.deleteDocument(
      databaseId: dID,
      collectionId: cID,
      documentId: id,
    );
    Map<String, dynamic> data = document.data;
    return data;
  }
}


