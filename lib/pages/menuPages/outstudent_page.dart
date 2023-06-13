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

  late Orientation orientation ;

  late double width ;

  final LogDatabase _log = LogDatabase() ;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    orientation = MediaQuery.of(context).orientation;

    width = MediaQuery. of(context). size. width ;

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
        body: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: FutureBuilder<List<Document>>(
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
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: DataTable(
                    border: TableBorder.all(color: Colors.white), // Border color for cell borders
                    columns: [
                      DataColumn(label: Padding(
                        padding: customPadding(orientation,width) ,
                        child: Text('ID', style : TextStyle(color: Colors.white,fontSize: customFontSize(orientation,width))),
                      )),
                      DataColumn(label: Padding(
                        padding: customPadding(orientation,width) ,
                        child: Text('Name', style : TextStyle(color: Colors.white,fontSize: customFontSize(orientation,width))),
                      )),
                      DataColumn(label: Padding(
                        padding: customPadding(orientation,width) ,
                        child: Text('Room', style : TextStyle(color: Colors.white,fontSize: customFontSize(orientation,width))),
                      )),
                      DataColumn(label: Padding(
                        padding: customPadding(orientation,width) ,
                        child: Text('Out time', style : TextStyle(color: Colors.white,fontSize: customFontSize(orientation,width))),
                      )),
                      DataColumn(label: Padding(
                        padding: customPadding(orientation,width) ,
                        child: Text('Mobile No', style : TextStyle(color: Colors.white,fontSize: customFontSize(orientation,width))),
                      )),
                    ],

                    rows: documents.map((document) {
                      final data = document.data;

                      var inTime = data['inTime'];
                      Color color = Colors.greenAccent;
                      if(inTime == 'null'){
                        inTime = '';
                        color = Colors.redAccent;
                      }

                      var outTime = data['date'][6] + data['date'][7] + "/" + data['date'][4] + data['date'][5] + " " + data['outTime'];

                      return DataRow(
                        cells: [
                          DataCell(Center(child: Text(data['id'], style: TextStyle(color: color,fontSize: customFontSize(orientation,width))))),
                          DataCell(Center(child: Text(data['name'], style:  TextStyle(color: color,fontSize: customFontSize(orientation,width))))),
                          DataCell(Center(child: Text(data['roomNo'], style:  TextStyle(color: color,fontSize: customFontSize(orientation,width))))),
                          DataCell(Center(child: Text(outTime, style:  TextStyle(color: color,fontSize: customFontSize(orientation,width))))),
                          DataCell(Center(child: Text(data['mobileNo'], style:  TextStyle(color: color,fontSize: customFontSize(orientation,width))))),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
