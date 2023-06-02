import 'package:flutter/material.dart';

import '../../common/constants.dart';
import '../../common/loading_page.dart';
import '../../services/auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final _formKey = GlobalKey<FormState>(); // GlobalKey for the form
  final AuthService _auth = AuthService() ;

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  bool loading = false ;
  late String error = '' ;

  void nextPage() {
    Navigator.pushReplacementNamed(context, "/home") ;
  }

  @override
  Widget build(BuildContext context) {
    return loading ? const Loading() : Scaffold(
      backgroundColor: Colors.black45,
      body: SingleChildScrollView(
        child: Container(
          padding:const EdgeInsets.symmetric(horizontal: 35.0, vertical: 80.0),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 15.0),
                  const Text(
                    "MAT SECURITY" ,
                    style: TextStyle(
                      letterSpacing: 1.5,
                      color: Colors.greenAccent,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  TextFormField(
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 20
                    ),
                    decoration: textInputDecoration.copyWith(hintText: "Email"),
                    validator: (val) => val == null || val.isEmpty ? "Enter an Email" : null,
                    controller: email,
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 20
                    ),
                    obscureText: true,
                    decoration: textInputDecoration.copyWith(hintText: "Password"),
                    validator: (val) => val == null || val.length < 6 ? "Enter a password 6+ characters long" : null,
                    controller: password,
                  ),
                  const SizedBox(height: 30.0),
                  Container(
                    height: 40,
                    width: 50,
                    decoration: BoxDecoration(
                        gradient: buttonRadialGradient_2,
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          elevation: 0
                      ),
                      onPressed: () async {
                        if(_formKey.currentState!.validate()){
                          setState(() => loading = true);
                          dynamic result = await _auth.registerWithEmailAndPassword(email.text.trim(), password.text);
                          if(result == null){
                            setState(() {
                              loading = false ;
                              error = 'Please Enter Valid Email' ;
                            });
                          }
                          else
                          {
                            nextPage();
                          }
                        }
                      },
                      child: const Text(
                        'SIGN UP',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    error,
                    style: const TextStyle(color: Colors.red, fontSize: 14.0),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
