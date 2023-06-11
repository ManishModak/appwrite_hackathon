
import 'dart:typed_data';
import 'package:appwrite/appwrite.dart';
import 'package:mat_security/services/main_database.dart';
import 'package:flutter/material.dart';
import 'package:mat_security/common/constants.dart';

class StudentInfo extends StatefulWidget {
  const StudentInfo({super.key});

  @override
  State<StudentInfo> createState() => _StudentInfoState();
}

class _StudentInfoState extends State<StudentInfo> {

  TextEditingController searchText = TextEditingController() ;

  MainDatabase data = MainDatabase();
  String id = '';
  String name = '';
  String branch = '';
  String room = '';
  String mobile = '';

  Future<void> submitButton() async {
    String value = searchText.text ;
    try {
      Map<String, dynamic> stuData = await data.getInfo(id: value);

      setState(() {
        id = stuData['id'];
        name = stuData['name'];
        branch = stuData['branch'];
        room = stuData['roomNo'];
        mobile = stuData['mobileNo'];
        searchText.clear() ;
      });
    } catch (e) {
      if (e is AppwriteException && e.type == 'document_not_found') {
        showSnackBar('$value not found.',context);
        setState(() {
          searchText.clear();
        });
      }
    }
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
          child: Container(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0) ,
            child: Column(
              children: [
                TextField(
                  controller: searchText,
                  decoration: textInputDecoration.copyWith(
                      hintText: "Search",
                      prefixIcon: const Icon(
                          Icons.search_outlined,
                          size: 30
                      ),
                  ),
                  style: const TextStyle(color: Colors.grey, fontSize: 20),
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
                    onPressed: submitButton,
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
                const Row(
                  children: [
                    Expanded(child: Divider(thickness: 1,color: Colors.redAccent,)),
                    SizedBox(width: 10,),
                    Text("Last Checked",style: TextStyle(fontSize: 15,color: Colors.white),),
                    SizedBox(width: 10,),
                    Expanded(child: Divider(thickness: 1,color: Colors.redAccent,))
                  ],
                ),
                const SizedBox(height: 20.0),
              FutureBuilder<Uint8List?>(
                future: data.getPic(id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return const Text('Error loading image');
                  } else if (snapshot.hasData && snapshot.data != null) {
                    return CircleAvatar(
                      radius: 50,
                      backgroundImage: MemoryImage(snapshot.data!),
                    );
                  } else {
                    return const CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.account_circle_outlined,size: 100,),
                    );
                  }
                },
              ),
                const SizedBox(height: 20.0),
                Container(decoration: boxDecoration(), child: customCard('ID: $id', context)),
                const SizedBox(height: 16.0),
                Container(decoration: boxDecoration() ,child: customCard('Name: $name', context)),
                const SizedBox(height: 16.0),
                Container(decoration: boxDecoration() ,child: customCard('Branch: $branch', context)),
                const SizedBox(height: 16.0),
                Container(decoration: boxDecoration() ,child: customCard('Room: $room', context)),
                const SizedBox(height: 16.0),
                Container(decoration: boxDecoration() ,child: customCard('Mobile: $mobile', context)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
