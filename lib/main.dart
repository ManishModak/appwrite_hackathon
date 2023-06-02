import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mat_security/pages/home_page.dart';
import 'package:mat_security/pages/authentication_pages/login_page.dart';
import 'package:mat_security/pages/menu_pages/manual_entry_page.dart';
import 'package:mat_security/pages/menu_page.dart';
import 'package:mat_security/pages/menu_pages/new_hostelite_page.dart';
import 'package:mat_security/pages/menu_pages/daily_log_page.dart';
import 'package:mat_security/services/main_database.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MainDatabase stu = MainDatabase();
  stu.addStudent(id: 'T21052', name: 'Aman Munjewar', room: '221', branch: 'IT', mobile: '9667745645', url: '');

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
      // Route for the loading page
      '/home': (context) => const Home(), // Route for the home page
      '/login': (context) => const Login(), // Route for the login page
      '/menu': (context) => const Menu(), // Route for the menu page
      '/newStudent': (context) => const NewStudent(), //Route for the New Hostelite page
      '/log':(context) => const DailyLog(),
      '/entry':(context) => const ManualEntryPage()
    },
  ));
}
