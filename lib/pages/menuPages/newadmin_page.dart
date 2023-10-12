import 'package:flutter/material.dart';
import 'package:mat_security/common/constants.dart';
import 'package:mat_security/services/admin_management.dart';

class NewAdmin extends StatefulWidget {
  const NewAdmin({super.key});

  @override
  State<NewAdmin> createState() => _NewAdminState();
}

class _NewAdminState extends State<NewAdmin> {
  final AdminManagement adminM = AdminManagement();

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  final TextEditingController email = TextEditingController();

  AdminManagement currentAdmin = AdminManagement();

  String messageShowed = '';

  void submitButton() async {
    String msg = await currentAdmin.newAdmin(email: email.text);

    if (formkey.currentState!.validate()) {
      setState(() {
        messageShowed = msg;
        email.clear();
      });
    }
  }

  @override
  void dispose() {
    email.dispose();
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
              decoration: const BoxDecoration(gradient: appBarGradient),
            ),
            buildAppBar1("New Admin"),
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
                    style: const TextStyle(color: Colors.grey, fontSize: 20),
                    decoration: textInputDecoration.copyWith(hintText: "Email"),
                    validator: (val) =>
                        val == null || val.isEmpty ? "Enter Email" : null,
                    controller: email,
                  ),
                ),
                const SizedBox(height: 20.0),
                Text(
                  messageShowed,
                  style: const TextStyle(color: Colors.red, fontSize: 16.0),
                ),
                const SizedBox(height: 20.0),
                Container(
                  width: 180,
                  height: 55,
                  decoration: BoxDecoration(
                      gradient: buttonLinearGradient_1,
                      borderRadius: BorderRadius.circular(10)),
                  child: ElevatedButton(
                    onPressed: submitButton,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent, elevation: 0),
                    child: const Text(
                      "Submit",
                      style: TextStyle(
                          fontSize: 23,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1.5),
                    ),
                  ),
                ),
              ],
            )),
      ),
    ));
  }
}
