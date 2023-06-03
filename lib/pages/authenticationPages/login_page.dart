import 'package:flutter/material.dart';
import 'package:mat_security/common/constants.dart';
import 'package:mat_security/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mat_security/common/loading_page.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final _formKey = GlobalKey<FormState>(); // GlobalKey for the form
  final AuthService _auth = AuthService() ;

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  bool loading = false ;
  late String error = '' ;

  @override
  void initState() {
    super.initState();
    loadLastUsedEmail();
  }

  Future<void> loadLastUsedEmail() async{
    SharedPreferences prefs = await SharedPreferences.getInstance() ;
    String? savedEmail = prefs.getString('email') ;

    if(savedEmail != null) {
      setState(() {
        email.text = savedEmail ;
      });
    }
  }

  void nextPage() {
    Navigator.pushReplacementNamed(context, "/entry") ;
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
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
                crossAxisAlignment: CrossAxisAlignment.center,
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
                    validator: (val) => val == null || val.length < 8 ? "Enter a password 8+ characters long" : null,
                    controller: password,
                  ),
                  const SizedBox(height: 30.0),
                  Container(
                    height: 50,
                    width: 400,
                    decoration: BoxDecoration(
                      gradient: buttonLinearGradient_1,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        elevation: 0
                      ),
                      child: const Text(
                        'LOGIN',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          letterSpacing: 1.25,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                      onPressed: () async{
                        if(_formKey.currentState!.validate()){
                          setState(() => loading = true);
                          dynamic result = await _auth.signInWithEmailAndPassword(email.text.trim(), password.text);
                          if(result == "invalid"){
                            setState(() {
                              loading = false ;
                              error = 'Could not sign in with those credentials' ;
                            });
                          }
                          else if(result == "unauthorised"){
                            setState(() {
                              loading = false ;
                              error = 'You Do not have access to app. Contact admin.' ;
                            });
                          }
                          else
                          {
                            nextPage();
                          }
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    height: 50,
                    width: 400,
                    decoration: BoxDecoration(
                      gradient: buttonLinearGradient_2,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          elevation: 0
                      ),
                      child: const Text(
                        'SIGN UP',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            letterSpacing: 1.25,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                      onPressed: () async{
                        if(_formKey.currentState!.validate()){
                          setState(() => loading = true);
                          dynamic result = await _auth.registerWithEmailAndPassword(email.text.trim(), password.text);
                          if(result == null){
                            setState(() {
                              loading = false ;
                              error = 'Could not sign up with those credentials' ;
                            });
                          }
                          else
                          {
                            setState(() {
                              loading = false ;
                              error = 'Signed up successfully. Contact admin for access.' ;
                            });
                          }
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    error,
                    style: const TextStyle(color: Colors.red, fontSize: 14.0),
                  ),
                  const SizedBox(height: 40.0),
                  Row(
                    children: [
                      Expanded(child: Divider(thickness: 1,color: Colors.redAccent,)),
                      SizedBox(width: 10,),
                      Text("Or Continue With",style: TextStyle(fontSize: 15,color: Colors.white),),
                      SizedBox(width: 10,),
                      Expanded(child: Divider(thickness: 1,color: Colors.redAccent,))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}