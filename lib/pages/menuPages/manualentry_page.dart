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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manual Entry'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('New Admin'),
              onTap: () {
                Navigator.pushNamed(context, "/newAdmin");
              },
            ),
            ListTile(
              title: const Text('New Student'),
              onTap: () {
                Navigator.pushNamed(context, "/newStudent");
              },
            ),
            ListTile(
              title: const Text("Student's List"),
              onTap: () {
                Navigator.pushNamed(context, "/list");
              },
            ),
            ListTile(
              title: const Text('Daily Log'),
              onTap: () {
                Navigator.pushNamed(context, "/log");
              },
            ),
            ListTile(
              title: const Text('Not returned'),
              onTap: () {
                Navigator.pushNamed(context, "/OutStud");
              },
            ),
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
    );
  }
}
