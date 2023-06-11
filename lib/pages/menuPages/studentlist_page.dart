
import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/foundation.dart';
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
  File? stuPic;

  void onTextChanged(String value){
      setState(() {
        searchText = value ;
      });
  }

  Future<void> call() async {
    try {
      Map<String, dynamic> stuData = await data.getInfo(id: searchText);
      var pic = (await data.getPic("id")) as File?;
      setState(() {
        id = stuData['id'];
        name = stuData['name'];
        branch = stuData['branch'];
        room = stuData['roomNo'];
        mobile = stuData['mobileNo'];
        stuPic = pic;
      });
    } catch (e) {
      if (e is AppwriteException && e.type == 'document_not_found') {
        nullAlert();
      } else {
        if (kDebugMode) {
          print('An error occurred: $e');
        }
      }
    }
  }

  void nullAlert() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        title: const Text(
          'Error',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60.0,
            ),
            const SizedBox(height: 10.0),
            Text(
              '$searchText not found.',
              style: const TextStyle(
                fontSize: 18.0,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'OK',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget callBack(){
    return Column(
      children: [
        const SizedBox(height: 16.0),
        const Text('Document Data:'),
        const SizedBox(height: 16.0),
        Text('ID: $id'),
        const SizedBox(height: 16.0),
        Text('Name: $name')   ,
        const SizedBox(height: 16.0),
        Text('Branch: $branch')   ,
        const SizedBox(height: 16.0),
        Text('Room: $room')   ,
        const SizedBox(height: 16.0),
        Text('Mobile: $mobile'),
      ],
    );
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
              buildAppBar1("Student Info") ,
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
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
              const SizedBox(height: 20.0),
              Container(
                width: 150,
                height: 55,
                decoration: BoxDecoration(
                    gradient: buttonLinearGradient_1,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: ElevatedButton(
                  onPressed: call,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0
                  ),
                  child:const Text(
                    "Submit",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1.5
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              CircleAvatar(
                backgroundImage: (stuPic != null) ? FileImage(stuPic!) : null,
                radius: 80,
                backgroundColor: Colors.grey,
              ),
              callBack(),
            ],
          ),
        ),
      ),
    );
  }
}
