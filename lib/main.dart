import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mat_security/pages/authenticationPages//login_page.dart';
import 'package:mat_security/pages/menuPages//manualentry_page.dart';
import 'package:mat_security/pages/menuPages/newadmin_page.dart';
import 'package:mat_security/pages/menuPages/outstudent_page.dart';
import 'package:mat_security/pages/menuPages/studentlist_page.dart';
import 'package:mat_security/pages/menu_page.dart';
import 'package:mat_security/pages/menuPages/newstudent_page.dart';
import 'package:mat_security/pages/menuPages/dailylog_page.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(

    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.black,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    themeMode: ThemeMode.system,

    initialRoute: '/login', // Set the initial route to '/login'
    routes: {

      '/list' : (context) => const StudentList(),
      '/newAdmin':(context) => const NewAdmin(),
      '/login': (context) => const Login(), // Route for the login page
      '/menu': (context) => const Menu(), // Route for the menu page
      '/newStudent': (context) => const NewStudent(), //Route for the New Hostelite page
      '/log':(context) => const DailyLog(),
      '/entry':(context) => const ManualEntry(),
      '/OutStud':(context) => const OutStudent()
    },
  ));
}
