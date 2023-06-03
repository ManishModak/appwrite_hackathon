import 'package:flutter/material.dart';
import 'package:mat_security/common/constants.dart';
import 'package:mat_security/services/log_database.dart';

class ManualEntry extends StatefulWidget {
  const ManualEntry({super.key});

  @override
  State<ManualEntry> createState() => _ManualEntryState();
}

class _ManualEntryState extends State<ManualEntry> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>() ;

  final TextEditingController id = TextEditingController() ;
  void logStudent(String id){
    LogDatabase log = LogDatabase();
    log.addLog(id: id);
  }

  void submitButton () async{

    if(formkey.currentState!.validate()) {
      logStudent(id as String);
      setState(() {
        id.clear() ;
      });

    }
  }

  @override
  void dispose() {
    id.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  gradient: appBarGradient
              ),
            ),
            buildAppBar2("Manual Entry",context),
          ],
        )
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: TextFormField(
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 20
                  ),
                  decoration: textInputDecoration.copyWith(hintText: "Student ID"),
                  validator: (val) => val == null || val.isEmpty ? "Enter ID" : null,
                  controller: id,
                ),
              ),
              const SizedBox(height:40.0),
              Container(
                width: 180,
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
    );
  }
}