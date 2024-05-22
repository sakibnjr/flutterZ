// login_page.dart
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'admin_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isAdmin = false;
  final TextEditingController _studentIdController = TextEditingController();
  final TextEditingController _sectionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text('Login as Admin'),
                Switch(
                  value: isAdmin,
                  onChanged: (value) {
                    setState(() {
                      isAdmin = value;
                    });
                  },
                ),
              ],
            ),
            isAdmin
                ? TextField(
                    controller: _studentIdController,
                    decoration: InputDecoration(labelText: 'Admin ID'),
                  )
                : Column(
                    children: [
                      TextField(
                        controller: _studentIdController,
                        decoration: InputDecoration(labelText: 'Student ID'),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        controller: _sectionController,
                        decoration: InputDecoration(labelText: 'Section'),
                      ),
                    ],
                  ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String studentId = _studentIdController.text;
                String section = _sectionController.text;

                if (!isAdmin) {
                  if (studentId.isEmpty || section.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please fill in all fields')),
                    );
                    return;
                  }

                  if (!RegExp(r'^\d{3}-\d{2}-\d{4}$').hasMatch(studentId)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Invalid Student ID format')),
                    );
                    return;
                  }

                  String name;
                  if (studentId == '213-15-4575' && section == '60_C') {
                    name = 'Nahid';
                  } else if (studentId == '213-15-4394') {
                    name = 'Palki';
                  } else {
                    name = 'Guest';
                  }

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(name: name),
                    ),
                  );
                } else {
                  if (studentId != 'admin') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Invalid Admin ID')),
                    );
                    return;
                  }

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdminPage(),
                    ),
                  );
                }
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
