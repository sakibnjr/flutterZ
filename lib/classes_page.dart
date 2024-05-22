import 'package:flutter/material.dart';

class ClassesPage extends StatelessWidget {
  static final Map<String, List<Map<String, String>>> classSchedule = {
    'Saturday': [
      {'title': 'Math', 'room': 'AB201', 'time': '8:00 AM - 3:10 AM'},
      {'title': 'English', 'room': 'AB202', 'time': '10:00 AM - 12:00 PM'}
    ],
    'Sunday': [
      {'title': 'Math', 'room': 'AB201', 'time': '8:00 AM - 3:10 AM'}
    ],
    'Monday': [
      {'title': 'English', 'room': 'AB304', 'time': '2:00 PM - 3:00 PM'},
      {'title': 'Biology', 'room': 'AB307', 'time': '11:00 AM - 4:00 PM'}
    ],
    'Tuesday': [
      {'title': 'Physics', 'room': 'AB576', 'time': '4:00 PM - 5:00 PM'},
      {'title': 'Chemistry', 'room': 'AB307', 'time': '11:00 AM - 1:00 PM'}
    ],
    'Wednesday': [
      {'title': 'Math', 'room': 'AB201', 'time': '8:00 AM - 3:10 AM'},
      {'title': 'English', 'room': 'AB202', 'time': '10:00 AM - 12:00 PM'}
    ],
    'Thursday': [
      {'title': 'Math', 'room': 'AB201', 'time': '8:00 AM - 3:10 AM'}
    ],
    'Friday': [
      {'title': 'No class', 'room': '', 'time': ''}
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Classes')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: classSchedule.keys.map((day) {
          return Card(
            child: ListTile(
              title: Text(day),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ClassDetailPage(day: day, classes: classSchedule[day]!),
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

class ClassDetailPage extends StatelessWidget {
  final String day;
  final List<Map<String, String>> classes;

  ClassDetailPage({required this.day, required this.classes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$day Classes')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: classes.map((classInfo) {
          return Card(
            child: ListTile(
              title: Text(classInfo['title']!),
              subtitle: Text(
                  'Room: ${classInfo['room']!}\nTime: ${classInfo['time']!}'),
            ),
          );
        }).toList(),
      ),
    );
  }
}
