import 'package:flutter/material.dart';
import 'package:mat_security/common/constants.dart';

class ManualEntryPage extends StatelessWidget {
  const ManualEntryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final GlobalKey<FormState> _formkey = GlobalKey<FormState>() ;

    final TextEditingController id = TextEditingController() ;

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
                buildAppBar("Manual Entry"),
              ],
            ),
          ),
          body: Container(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: _formkey,
              child:Column(
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
                      gradient: buttonLinearGradient,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: ElevatedButton(
                      onPressed: () async{

                      },
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
              )
            ),
          ),
        )
    );
  }
}
