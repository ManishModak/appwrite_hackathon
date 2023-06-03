import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mat_security/pages/authenticationPages//login_page.dart';
import 'package:mat_security/pages/menuPages//manualentry_page.dart';
import 'package:mat_security/pages/menuPages/newAdmin_page.dart';
import 'package:mat_security/pages/menu_page.dart';
import 'package:mat_security/pages/menuPages/newstudent_page.dart';
import 'package:mat_security/pages/menuPages/dailyLog_page.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(

    debugShowCheckedModeBanner: false,
    theme: ThemeData.light(),
    darkTheme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.black,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    themeMode: ThemeMode.system,

    initialRoute: '/login', // Set the initial route to '/login'
    routes: {
      '/newAdmin':(context) => const NewAdmin(),
      '/login': (context) => const Login(), // Route for the login page
      '/menu': (context) => const Menu(), // Route for the menu page
      '/newStudent': (context) => const NewStudent(), //Route for the New Hostelite page
      '/log':(context) => const DailyLog(),
      '/entry':(context) => const ManualEntry()
    },
  ));
}
