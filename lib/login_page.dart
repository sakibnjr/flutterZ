import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'home_page.dart';
import 'admin_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isAdmin = false;
  final TextEditingController _studentIdController = TextEditingController();
  final TextEditingController _sectionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   centerTitle: true,

        //   title: Text('Login'),
        // ),
        body: Stack(
      children: [
        SvgPicture.asset(
          'assets/login.svg',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: [
                  const Text(
                    'Welcome Back!',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Please login to continue',
                    style: TextStyle(fontSize: 14, color: Colors.blue[700]),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Login as Admin',
                      style: TextStyle(fontSize: 18),
                    ),
                    Switch(
                      value: isAdmin,
                      activeColor: Colors.lightBlue,
                      onChanged: (value) {
                        setState(() {
                          isAdmin = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              isAdmin
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: _studentIdController,
                        decoration: InputDecoration(
                          icon: const Icon(Icons.add_moderator_outlined),
                          iconColor: Colors.lightBlue,
                          labelText: 'Admin ID',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ))
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          TextField(
                            controller: _studentIdController,
                            decoration: InputDecoration(
                              icon: const Icon(Icons.person),
                              iconColor: Colors.lightBlue,
                              labelText: 'Student ID',
                              hintText: 'XXX-XX-XXXX',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: _sectionController,
                            decoration: InputDecoration(
                              icon: const Icon(Icons.category),
                              iconColor: Colors.lightBlue,
                              labelText: 'Section',
                              hintText: '60_C',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 18),
                  padding: const EdgeInsets.symmetric(
                      vertical: 8, horizontal: 80), // Adjust padding
                  shadowColor: Colors.blueAccent,
                  backgroundColor: Colors.lightBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  String studentId = _studentIdController.text;
                  String section = _sectionController.text;

                  if (!isAdmin) {
                    if (studentId.isEmpty || section.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Please fill in all fields')),
                      );
                      return;
                    }

                    if (!RegExp(r'^\d{3}-\d{2}-\d{4}$').hasMatch(studentId)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Invalid Student ID format')),
                      );
                      return;
                    }

                    String name;
                    if (studentId == '213-15-4575' && section == '60_C') {
                      name = 'Nahid';
                    } else if (studentId == '213-15-4394') {
                      name = 'Palki';
                    } else if (studentId == '212-15-4164') {
                      name = 'Rayhan';
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
                        const SnackBar(content: Text('Invalid Admin ID')),
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
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
