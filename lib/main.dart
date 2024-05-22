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
        '/': (context) => const LoginPage(),
        '/home': (context) {
          final args =
              ModalRoute.of(context)!.settings.arguments as Map<String, String>;
          final name = args['name'] ?? 'Guest';
          return HomePage(name: name);
        },
        '/classes': (context) {
          final args =
              ModalRoute.of(context)!.settings.arguments as Map<String, String>;
          final name = args['name'] ?? 'Guest';
          return ClassesPage();
        },
        '/assignments': (context) {
          final args =
              ModalRoute.of(context)!.settings.arguments as Map<String, String>;
          final name = args['name'] ?? 'Guest';
          return AssignmentsPage(name: name);
        },
        '/admin': (context) => const AdminPage(),
        '/announcements': (context) {
          final args =
              ModalRoute.of(context)!.settings.arguments as Map<String, String>;
          final name = args['name'] ?? 'Guest';
          return AnnouncementPage(name: name);
        },
      },
    );
  }
}
