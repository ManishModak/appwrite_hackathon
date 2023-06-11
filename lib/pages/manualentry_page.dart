import 'package:flutter/material.dart';
import 'package:mat_security/common/constants.dart';
import 'package:mat_security/services/log_database.dart';

class ManualEntry extends StatefulWidget {
  const ManualEntry({Key? key}) : super(key: key);

  @override
  State<ManualEntry> createState() => _ManualEntryState();
}

class _ManualEntryState extends State<ManualEntry> {

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final TextEditingController id = TextEditingController();
  String messageShowed = '';

  bool _isValidId(String id) {
    final RegExp validIdRegex = RegExp(r'^[a-zA-Z0-9][a-zA-Z0-9_]*$');
    return validIdRegex.hasMatch(id);
  }

  Future<void> logStudent(String id) async{

    if (!_isValidId(id)) {
      showSnackBar('Invalid ID',context);
      return;
    }

    LogDatabase log = LogDatabase();
    String operationPerformed = await log.addLog(id: id) ;

    setState(() {
      messageShowed = operationPerformed ;
    });
  }

  void submitButton() async {
    if (formkey.currentState!.validate()) {

      logStudent(id.text);

      setState(() {
        id.clear();
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
              buildAppBar1("Manual Entry"),
            ],
          ),
        ),
        drawer: Drawer(
          backgroundColor: Colors.black,
          child: ListView(
            children: [
              Container(
                height: 100,
                decoration: const BoxDecoration(
                  gradient: appBarGradient
                ),
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    'Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      letterSpacing: 1.25
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,
                          decoration: boxDecoration(),
                          child: menuCard("New Admin", "newAdmin", context),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,
                          decoration: boxDecoration(),
                          child: menuCard("New Student","newStudent",context),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,
                          decoration: boxDecoration(),
                          child: menuCard("Student Info","list",context),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,
                          decoration: boxDecoration(),
                          child: menuCard("Daily Log","log",context),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,
                          decoration: boxDecoration(),
                          child: menuCard("Not returned","OutStud",context),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
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
                const SizedBox(height:20.0),
                Text(
                  messageShowed ,
                  style: const TextStyle(color: Colors.red, fontSize: 16.0),
                ),
                const SizedBox(height:20.0),
                Container(
                  width: 180,
                  height: 55,
                  decoration: BoxDecoration(
                      gradient: buttonLinearGradient_1,
                      borderRadius: BorderRadius.circular(12)
                  ),
                  child: ElevatedButton(
                    onPressed: submitButton,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
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
      ),
    );
  }
}
