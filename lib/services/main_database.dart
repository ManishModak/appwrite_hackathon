import 'package:appwrite/appwrite.dart';

class MainDatabase {
  final Client _client = Client();
  late final Databases _database = Databases(_client);
  String dID = '647a0fa72e02c1bdcc70';

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
    required String url,
  }) async {
    final document = await _database.createDocument(
      collectionId: 'users',
      databaseId: dID,
      documentId: ID.unique(),
      data: {
        'id': id,
        'name': name,
        'roomNo': room,
        'branch': branch,
        'mobileNo': mobile,
        'imageUrl': url,
      },
    );
  }

  Future<Map<String, dynamic>> getInfo({required String id}) async {
    final document = await _database.getDocument(
      collectionId: 'users',
      documentId: id,
      databaseId: dID,
    );
    Map<String, dynamic> data = document.data;
    return data;
  }

  Future<void> updateRoom({required String id, required String room}) async {
    final document = await _database.updateDocument(
      collectionId: 'users',
      documentId: id,
      databaseId: dID,
      data: {'roomNo': room},
    );
  }

  Future<void> updateBranch({required String id, required String branch}) async {
    final document = await _database.updateDocument(
      databaseId: dID,
      collectionId: 'users',
      documentId: id,
      data: {'branch': branch},
    );
  }

  Future<void> deleteStudent({required String id}) async {
    final document = await _database.deleteDocument(
      databaseId: dID,
      collectionId: 'users',
      documentId: id,
    );
  }
}


