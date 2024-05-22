import 'package:flutter/material.dart';

class AssignmentsPage extends StatelessWidget {
  static final Map<String, List<String>> assignments = {
    'Math': ['Do Calculus HW'],
    'English': ['Write a paragraph'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Assignments')),
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
                        subject: subject, assignments: assignments[subject]!),
                  ),
                );
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}

class AssignmentDetailPage extends StatelessWidget {
  final String subject;
  final List<String> assignments;

  AssignmentDetailPage({required this.subject, required this.assignments});

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
