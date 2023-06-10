
import 'package:mat_security/services/main_database.dart';
import 'package:flutter/material.dart';
import 'package:mat_security/common/constants.dart';

class StudentList extends StatefulWidget {
  const StudentList({super.key});

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  MainDatabase data = MainDatabase();
  String searchText = '';
  String id = '';
  String name = '';
  String branch = '';
  String room = '';
  String mobile = '';

  void onTextChanged(String value){
      setState(() {
        searchText = value ;
      });
  }

  Future<void> call() async {
    Map<String, dynamic> stuData = await data.getInfo(id: searchText);
    setState(() {
      id = stuData['id'];
      name = stuData['name'];
      branch = stuData['branch'];
      room = stuData['roomNo'];
      mobile = stuData['mobileNo'];
    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
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
                child: const Text("Submit")),
            const SizedBox(height: 16.0),
            const Text('Document Data:')   ,
            const SizedBox(height: 16.0),
            Text('ID: $id')   ,
            const SizedBox(height: 16.0),
            Text('Name: $name')   ,
            const SizedBox(height: 16.0),
            Text('Branch: $branch')   ,
            const SizedBox(height: 16.0),
            Text('Room: $room')   ,
            const SizedBox(height: 16.0),
            Text('Mobile: $mobile')   ,

          ],
        ),
      ),
    );
  }
}
