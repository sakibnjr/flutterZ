// main.dart
import 'package:flutter/material.dart';
import 'login_page.dart';
import 'home_page.dart';
import 'classes_page.dart';
import 'assignments_page.dart';
import 'admin_page.dart';
import 'announcement_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/home': (context) =>
            const HomePage(name: ''), // Provide a default value for name
        '/classes': (context) => ClassesPage(),
        '/assignments': (context) => AssignmentsPage(),
        '/admin': (context) => AdminPage(),
        '/announcements': (context) => AnnouncementPage(),
      },
    );
  }
}
