
import 'package:mat_security/services/main_database.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mat_security/common/constants.dart';

class StudentList extends StatefulWidget {
  const StudentList({super.key});

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {

  String searchText = '';
  late FutureBuilder<List<Document>> future;

  void onTextChanged(String value){

      setState(() {
        searchText = value ;
      });
  }

  Future<void> call() async {
    MainDatabase data = MainDatabase();
    final StringBuffer stringBuilder = StringBuffer();
    Map<String, dynamic> stuData = await data.getInfo(id: searchText);

    stringBuilder.writeln('Document Data:');
    stringBuilder.writeln('ID: ${stuData['id']}');
    stringBuilder.writeln('Name: ${stuData['name']}');
    stringBuilder.writeln('Branch: ${stuData['branch']}');
    stringBuilder.writeln('Room: ${stuData['roomNo']}');
    stringBuilder.writeln('Mobile: ${stuData['mobileNo']}');
    String result = stringBuilder.toString();
    if (kDebugMode) {
      print(result);
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: appBarGradient
                ),
              ),
              buildAppBar1("Student's List") ,
            ],
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 16, 10, 0) ,
              child: TextField(
                onChanged: onTextChanged ,
                decoration: textInputDecoration.copyWith(
                    hintText: "Search",
                    prefixIcon: const Icon(
                        Icons.search_outlined,
                        size: 30
                    ),
                ),
                style: const TextStyle(color: Colors.grey, fontSize: 20),
              ),
            ),
            const SizedBox(height: 16.0),
            Text('Search Text: $searchText')   ,
            ElevatedButton(
                onPressed: (){
                  call();
                },
                child: const Text("Submit"))
          ],
        ),
      ),
    );
  }
}
