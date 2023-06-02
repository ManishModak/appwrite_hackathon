import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mat_security/services/main_database.dart';

import '../common/constants.dart';

class NewStudent extends StatefulWidget {
  const NewStudent({Key? key}) : super(key: key);

  @override
  State<NewStudent> createState() => _NewStudentState();
}

class _NewStudentState extends State<NewStudent> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>() ;

  final TextEditingController id = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController roomNo = TextEditingController();
  final TextEditingController branch = TextEditingController();
  final TextEditingController mobileNo = TextEditingController();

  File? studentPic;
  double percentage=0;

@override
void dispose() {
  super.dispose();
  id.dispose();
  name.dispose();
  roomNo.dispose();
  branch.dispose();
  mobileNo.dispose();
}

void _submitForm() async{

  MainDatabase student = MainDatabase();

  UploadTask uploadTask = FirebaseStorage.instance.ref().child("pictures").child(id.text).child(id.text).putFile(studentPic!);

  uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
    setState(() {
      percentage = (snapshot.bytesTransferred/snapshot.totalBytes);
    });
  });
  TaskSnapshot taskSnapshot = await uploadTask;
  String downloadUrl =  await taskSnapshot.ref.getDownloadURL();

  student.addStudent(
      id: id.text ,
      name: name.text,
      room: roomNo.text,
      branch: branch.text,
      mobile: mobileNo.text,
      url: downloadUrl
  );

  setState(() {
    percentage = 0;
    studentPic = Null as File? ;
  });

  id.clear();
  name.clear();
  roomNo.clear();
  branch.clear();
  mobileNo.clear();
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
              buildAppBar("New Hostilite")
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding:const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 180,
                          height: 180,
                          child: CircularProgressIndicator(
                            value: percentage,
                            backgroundColor: Colors.black45,
                            strokeWidth: 5,
                            valueColor: const AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                          ),
                        ),
                        CupertinoButton(
                          onPressed: () async {
                            percentage = 0;
                            XFile? selectedImage = await ImagePicker().pickImage(source: ImageSource.camera);

                            if(selectedImage != null){
                              File convertedImage = File(selectedImage.path);
                              setState(() {
                                studentPic = convertedImage;
                              });
                            }
                            else{
                              if (kDebugMode) {
                                print("Image not selected");
                              }
                            }
                          },
                          child: CircleAvatar(
                            backgroundImage: (studentPic != null) ? FileImage(studentPic!) : null,
                            radius: 80,
                            backgroundColor: Colors.grey,
                          ),
                        ),
                      ]
                    ),
                  ),
                  const Divider(
                    height: 40.0,
                  ),
                  TextFormField(
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 20
                    ),
                    decoration: textInputDecoration.copyWith(hintText: "ID"),
                    validator: (val) => val == null || val.isEmpty ? "Enter ID" : null,
                    controller: id,
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 20
                    ),
                    decoration: textInputDecoration.copyWith(hintText: "Name"),
                    validator: (val) => val == null || val.isEmpty ? "Enter Name" : null,
                    controller: name,
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 20
                    ),
                    decoration: textInputDecoration.copyWith(hintText: "Room No"),
                    validator: (val) => val == null || val.isEmpty ? "Enter Room No" : null,
                    controller: roomNo,
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 20
                    ),
                    decoration: textInputDecoration.copyWith(hintText: "Branch"),
                    validator: (val) => val == null || val.isEmpty ? "Enter Branch" : null,
                    controller: branch,
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 20
                    ),
                    decoration: textInputDecoration.copyWith(hintText: "Mobile No"),
                    validator: (val) => val == null || val.isEmpty ? "Enter Mobile No" : null,
                    controller: mobileNo,
                  ),
                  const SizedBox(height: 40.0),
                  Container(
                    width: 180,
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: buttonLinearGradient
                    ),
                    child: ElevatedButton(
                      onPressed: () async{
                        if(_formKey.currentState!.validate()){
                          _submitForm();
                        }
                      } ,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        elevation: 0
                      ),
                      child: const Text(
                        "Submit",
                        style: TextStyle(
                          fontSize: 23,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1.5
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}
