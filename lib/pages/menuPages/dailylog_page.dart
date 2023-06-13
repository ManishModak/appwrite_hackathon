import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:mat_security/common/constants.dart';
import 'package:mat_security/services/log_database.dart';


class DailyLog extends StatefulWidget {
  const DailyLog({Key? key}) : super(key: key);

  @override
  State<DailyLog> createState() => _DailyLogState();
}

class _DailyLogState extends State<DailyLog> {

  late double width ;

  late Orientation orientation ;

  final LogDatabase _log = LogDatabase() ;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    width = MediaQuery. of(context). size. width ;

    orientation = MediaQuery.of(context).orientation;

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
              buildAppBar1("Daily Log")
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: FutureBuilder<List<Document>>(
            future: _log.getDocuments() ,
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
                        child: Text('In time', style : TextStyle(color: Colors.white,fontSize: customFontSize(orientation,width))),
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

                      return DataRow(
                        cells: [
                          DataCell(Center(child: Text(data['id'], style: TextStyle(color: color,fontSize: customFontSize(orientation,width))))),
                          DataCell(Center(child: Text(data['name'], style:  TextStyle(color: color,fontSize: customFontSize(orientation,width))))),
                          DataCell(Center(child: Text(data['roomNo'], style:  TextStyle(color: color,fontSize: customFontSize(orientation,width))))),
                          DataCell(Center(child: Text(data['outTime'], style:  TextStyle(color: color,fontSize: customFontSize(orientation,width))))),
                          DataCell(Center(child: Text(inTime, style:  TextStyle(color: color,fontSize: customFontSize(orientation,width))))),
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
