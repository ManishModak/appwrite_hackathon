import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:mat_security/common/constants.dart';
import 'package:mat_security/services/log_database.dart';

class OutStudent extends StatefulWidget {
  const OutStudent({super.key});

  @override
  State<OutStudent> createState() => _OutStudentState();
}

class _OutStudentState extends State<OutStudent> {
  final LogDatabase _log = LogDatabase() ;

  @override
  void initState() {
    super.initState();
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
              buildAppBar1("Not Returned")
            ],
          ),
        ),
        body: FutureBuilder<List<Document>>(
          future: _log.getNotReturned() ,
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
                      DataColumn(label: Text('Out time', style: TextStyle(color: Colors.white))),
                      DataColumn(label: Text('In time', style: TextStyle(color: Colors.white))),
                    ],
                    rows: documents.map((document) {
                      final data = document.data;

                      var inTime = data['inTime'];
                      Color color = Colors.greenAccent;
                      if(inTime == 'null'){
                        inTime = '';
                        color = Colors.redAccent;
                      }
                      return DataRow(
                        cells: [
                          DataCell(Text(data['id'], style: TextStyle(color: color))),
                          DataCell(Text(data['name'], style:  TextStyle(color: color))),
                          DataCell(Text(data['roomNo'], style:  TextStyle(color: color))),
                          DataCell(Text(data['outTime'], style:  TextStyle(color: color))),
                          DataCell(Text(inTime, style:  TextStyle(color: color))),
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
}
