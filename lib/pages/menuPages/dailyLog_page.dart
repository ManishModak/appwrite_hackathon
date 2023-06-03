import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../common/constants.dart';


class DailyLog extends StatefulWidget {
  const DailyLog({Key? key}) : super(key: key);

  @override
  State<DailyLog> createState() => _DailyLogState();
}

class _DailyLogState extends State<DailyLog> {
  final Client _client = Client();
  late final Databases _database;
  String dID = '647a0fa72e02c1bdcc70';

  DateTime currentTime = DateTime.now();

  @override
  void initState() {
    super.initState();

    _client
        .setEndpoint('https://cloud.appwrite.io/v1') // Replace with your Appwrite endpoint
        .setProject('6479bcbb10618eda232a'); // Replace with your Appwrite project ID

    _database = Databases(_client);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: appBarGradient,
                ),
              ),
              buildAppBar2("Daily Log",context)
            ],
          ),
        ),
        body: FutureBuilder<List<Document>>(
          future: _getDocuments(),
          builder: (BuildContext context, AsyncSnapshot<List<Document>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            final documents = snapshot.data;

            if (documents == null || documents.isEmpty) {
              return const Center(
                child: Text(
                  "NO DATA AVAILABLE",
                  style: TextStyle(
                    fontSize: 20,
                    letterSpacing: 1.25,
                  ),
                ),
              );
            }

            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                ),
                child: FittedBox(
                  child: DataTable(
                    columnSpacing: 16,
                    border: TableBorder.all(color: Colors.white), // Border color for cell borders
                    // Adjust the spacing between columns
                    columns: const [
                      DataColumn(label: Text('ID', style: TextStyle(color: Colors.white))),
                      DataColumn(label: Text('Name', style: TextStyle(color: Colors.white))),
                      DataColumn(label: Text('Room', style: TextStyle(color: Colors.white))),
                      DataColumn(label: Text('Out time', style: TextStyle(color: Colors.redAccent))),
                      DataColumn(label: Text('In time', style: TextStyle(color: Colors.greenAccent))),
                    ],
                    rows: documents.map((document) {
                      final data = document.data;

                      return DataRow(
                        cells: [
                          DataCell(Text(data['id'], style: const TextStyle(color: Colors.white))),
                          DataCell(Text(data['name'], style: const TextStyle(color: Colors.white))),
                          DataCell(Text(data['roomNo'], style: const TextStyle(color: Colors.white))),
                          DataCell(Text(data['outTime'], style: const TextStyle(color: Colors.redAccent))),
                          DataCell(Text(data['inTime'], style: const TextStyle(color: Colors.greenAccent))),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<List<Document>> _getDocuments() async {
    final formattedDate = DateFormat('yyyy:MM:dd').format(currentTime);
    final response = await _database.listDocuments(
      collectionId: formattedDate,
      databaseId: dID,
    );

    return response.documents;
  }
}
