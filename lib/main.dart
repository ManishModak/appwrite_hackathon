import 'package:flutter/material.dart';
import 'package:mat_security/pages/authenticationPages//login_page.dart';
import 'package:mat_security/pages/manualentry_page.dart';
import 'package:mat_security/pages/menuPages/newadmin_page.dart';
import 'package:mat_security/pages/menuPages/outstudent_page.dart';
import 'package:mat_security/pages/menuPages/studentinfo_page.dart';
import 'package:mat_security/pages/menuPages/newstudent_page.dart';
import 'package:mat_security/pages/menuPages/dailylog_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
      '/info': (context) => const StudentInfo(),
      '/newAdmin': (context) => const NewAdmin(),
      '/login': (context) => const Login(), // Route for the login page
      '/newStudent': (context) =>
          const NewStudent(), //Route for the New Hostelite page
      '/log': (context) => const DailyLog(),
      '/entry': (context) => const ManualEntry(),
      '/OutStud': (context) => const OutStudent()
    },
  ));
}
