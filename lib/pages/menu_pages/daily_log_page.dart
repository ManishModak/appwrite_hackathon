import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../common/constants.dart';


class DailyLog extends StatefulWidget {
  const DailyLog({Key? key}) : super(key: key);

  @override
  State<DailyLog> createState() => _DailyLogState();
}

class _DailyLogState extends State<DailyLog> {

  DateTime currentTime = DateTime.now();

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
                    gradient: appBarGradient
                ),
              ),
              buildAppBar("Daily Log")
            ],
          ),
        ),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance.collection(DateFormat('yyyy:MM:dd').format(currentTime)).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text(
                  "NO DATA AVAILABLE",
                  style: TextStyle(
                    fontSize: 20 ,
                    letterSpacing: 1.25
                  ),
                ),
              );
            }

            final documents = snapshot.data!.docs;

            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                ),
                child: FittedBox(
                  child: DataTable(
                    columnSpacing: 16,
                    border: TableBorder.all(color: Colors.white), // Border color for cell borders// Adjust the spacing between columns
                    columns: const [
                      DataColumn(label: Text('ID',style: TextStyle(color: Colors.white))),
                      DataColumn(label: Text('Name',style: TextStyle(color: Colors.white))),
                      DataColumn(label: Text('Room',style: TextStyle(color: Colors.white))),
                      DataColumn(label: Text('Out time',style: TextStyle(color: Colors.redAccent))),
                      DataColumn(label: Text('In time',style: TextStyle(color: Colors.greenAccent))),
                    ],
                    rows: documents.map((DocumentSnapshot<Map<String, dynamic>> document) {
                      final data = document.data();

                      return DataRow(
                        cells: [
                          DataCell(Text(data?['id'],style: const TextStyle(color: Colors.white))),
                          DataCell(Text(data?['name'],style: const TextStyle(color: Colors.white))),
                          DataCell(Text(data?['roomNo'],style: const TextStyle(color: Colors.white))),
                          DataCell(Text(data?['outTime'],style: const TextStyle(color: Colors.redAccent))),
                          DataCell(Text(data?['inTime'],style: const TextStyle(color: Colors.greenAccent))),
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
