import 'package:flutter/material.dart';

class AssignmentsPage extends StatelessWidget {
  static final Map<String, List<String>> assignments = {
    'System Analysis': ['Prepare SRS Document'],
    'Pervasive Computing': ['Lab Task 1,2'],
  };

  final String name;

  const AssignmentsPage({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Tasks',
        style: TextStyle(
          color: Colors.lightBlue,
        ),
      )),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: assignments.keys.map((subject) {
          return Card(
            child: ListTile(
              title: Text(subject),
              subtitle: Text('${assignments[subject]!.length} assignment(s)'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AssignmentDetailPage(
                      subject: subject,
                      assignments: assignments[subject]!,
                      name: name,
                    ),
                  ),
                );
              },
            ),
          );
        }).toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.class_outlined),
            label: 'Classes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.announcement),
            label: 'Announcements',
          ),
        ],
        currentIndex: 2, // Set the initial selected index
        selectedItemColor: Colors.lightBlue, // Color for selected item
        unselectedItemColor: Colors.grey, // Color for unselected items
        backgroundColor:
            Colors.white, // Background color of the bottom navigation bar
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/home', arguments: {'name': name});
          } else if (index == 1) {
            Navigator.pushNamed(context, '/classes', arguments: {'name': name});
          } else if (index == 2) {
            Navigator.pushNamed(context, '/assignments',
                arguments: {'name': name});
          } else if (index == 3) {
            Navigator.pushNamed(context, '/announcements',
                arguments: {'name': name});
          }
        },
      ),
    );
  }
}

class AssignmentDetailPage extends StatelessWidget {
  final String subject;
  final List<String> assignments;
  final String name;

  const AssignmentDetailPage(
      {super.key,
      required this.subject,
      required this.assignments,
      required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$subject Assignments')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: assignments.map((assignment) {
          return Card(
            child: ListTile(
              title: Text(assignment),
            ),
          );
        }).toList(),
      ),
    );
  }
}
